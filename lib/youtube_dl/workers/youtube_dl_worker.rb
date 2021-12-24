require "open3"

class YoutubeDlWorker
  include Sidekiq::Worker
  include LocalVideo

  def perform(arg)
    repo = VideoRepository.new

    video = repo.find_with_location(arg["id"])
    raise StandardError.new "Could not find video id #{arg['id']}" if !video


    if !([ VideoState.created, VideoState.restarted ].include?(video.state_id))
      Hanami.logger.info "Video #{video.url} state is #{video.state_text}. Download skipped"
      Hanami.logger.info "Video #{video.url} state is #{video.state_text}. Download skipped"
      return
    end

    repo.update(video.id, state_id: VideoState.processing)
    Dir.chdir(video.location.full_path)

    update_info(video)

    if download_video(video.url, video.location.full_path).exitstatus != 0
      repo.update(video.id, state_id: VideoState.error)
      raise "Error downloading video #{video.url}"
    end

    repo.update(video.id, state_id: VideoState.done)
    Hanami.logger.info "Finished downloading video #{video.url} to #{video.location.path}"
  end

  def update_info(video)
    video_repo = VideoRepository.new

    json = get_info(video.url)
    new_info = VideoInfo.create_from_youtube(json)

    if video.video_info
      video_repo.update_video_info(video, new_info)
    else
      video_repo.add_video_info(video, new_info)
    end
  end

  def get_info(video)
    id, _, exit_status = run_command("youtube-dl --get-id #{video}", "Getting id for  #{video}")
    return nil if exit_status !=0

    _, _, exit_status = run_command("youtube-dl --write-info-json --skip-download --id #{video}", "Getting info for  #{video}")
    return nil if exit_status !=0

    json = JSON.parse(File.read("#{id}.info.json"))
    File.delete("#{id}.info.json")

    return json
  end

  def download_video(video, location)
    _, _, exit_status = run_command("youtube-dl #{video}", "Downloading video #{video} to #{location}")
    exit_status
  end
end