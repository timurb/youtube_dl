require "open3"

class YoutubeDlWorker
  include Sidekiq::Worker

  def perform(arg)
    repo = VideoRepository.new

    video = repo.find_with_location(arg["id"])
    raise StandardError.new "Could not find video id #{arg['id']}" if !video


    if !([ VideoState.created, VideoState.restarted ].include?(video.state))
      p [ VideoState.created, VideoState.restarted ], video.state
      Hanami.logger.info "Video #{video.url} state is #{video.state_const}. Download skipped"
      return
    end

    repo.update(video.id, state: VideoState.processing)
    Dir.chdir(video.location.full_path)

    update_info(video)

    if download_video(video.url, video.location.full_path).exitstatus != 0
      repo.update(video.id, state: VideoState.error)
      raise "Error downloading video #{video.url}"
    end

    repo.update(video.id, state: VideoState.done)
    Hanami.logger.info "Finished downloading video #{video.url} to #{video.location.path}"
  end

  def download_video(video, location)
    _, _, exit_status = run_command("youtube-dl #{video}", "Downloading video #{video} to #{location}")
    exit_status
  end

  def update_info(video)
    id, _, exit_status = run_command("youtube-dl --get-id #{video.url}", "Getting id for  #{video.url}")
    return if exit_status !=0

    _, _, exit_status = run_command(
      "youtube-dl --write-info-json --skip-download --id #{video.url}",
      "Getting info for  #{video.url}"
     )
    return if exit_status !=0

    json = JSON.parse(File.read("#{id}.info.json"))
    File.delete("#{id}.info.json")

    if !json
      raise "Error processing JSON for #{video}"
    end

    video_repo = VideoRepository.new
    info_repo = VideoInfoRepository.new

    video_info = info_repo.find(youtube_id: json['id'])
    new_info = VideoInfo.create_from_youtube(json)
    if video.video_info
      video_repo.update_video_info(video.id, new_info)
    else
      video_repo.add_video_info(video.id, new_info)
    end
  end

  def run_command(command, description)
    Hanami.logger.info description
    stdin, stdout, stderr, wait_thr = Open3.popen3(command)
    exit_status = wait_thr.value
    lines_stdout = stdout.read
    lines_stderr = stderr.read
    if exit_status != 0
      Hanami.logger.error "Exit status: #{exit_status}"
      Hanami.logger.debug "STDOUT: #{lines_stdout}"
      Hanami.logger.debug "STDERR: #{lines_stderr}"
    end
    [lines_stdout.chomp, lines_stderr, exit_status]
  end
end