require "open3"

class YoutubeDlWorker
  include Sidekiq::Worker
  include LocalVideo

  def perform(arg)
    repo = VideoRepository.new

    video = repo.find_with_location(arg['id'])
    raise "Could not find video id #{arg['id']}" if !video
    raise "Requested video URL #{arg['url']} doesn't match existing #{video.url}" if arg['url'] != video.url

    if !VideoState.pending?(video.state_id)
      Hanami.logger.info "Video #{video.url} state is #{video.state_text}. Download skipped"
      return
    end

    repo.update(video.id, state_id: VideoState.processing)
    Dir.chdir(video.location.full_path)

    video_info = update_info(video)

    if download_video(video.url).exitstatus != 0
      repo.update(video.id, state_id: VideoState.error)
      raise "Error downloading video #{video.url}"
    end

    info = update_filename(video_info)

    repo.update(video.id, state_id: VideoState.done)
    Hanami.logger.info "Finished downloading video #{video.url} to #{video.location.path}"
  end

  def update_info(video)
    video_repo = VideoRepository.new
    info_repo = VideoInfoRepository.new

    json = get_info(video.url)
    new_info = VideoInfo.create_from_youtube(json)

    if info_repo.find_by_video(video.id).first
      video_repo.update_video_info(video, new_info)
    else
      video_repo.add_video_info(video, new_info)
    end
  end

  def get_info(video)
    id, _, exit_status = run_command("youtube-dl --get-id #{video}", "Getting id for  #{video}")
    return nil if exit_status !=0

    filename, _, exit_status = run_command("youtube-dl --get-filename #{video}", "Getting filename for  #{video}")
    return nil if exit_status !=0

    _, _, exit_status = run_command("youtube-dl --write-info-json --skip-download --id #{video}", "Getting info for  #{video}")
    return nil if exit_status !=0

    json = JSON.parse(File.read("#{id}.info.json"))
    File.delete("#{id}.info.json")
    json['_filename'] = filename

    return json
  end

  def download_video(video)
    stdout, _, exit_status = run_command("youtube-dl #{video}", "Downloading video #{video}")
    Hanami.logger.debug stdout
    exit_status
  end

  def update_filename(info)
    repo = VideoInfoRepository.new
    filename = discover_file(info['filename'])
    filename = info['filename'] if !filename

    repo.update(info['id'], filename: filename)
  end

  def discover_file(filename)
    [
      filename,
      "#{File.basename(filename, '.mp4')}.mkv",
    ].each do |file|
        return file if File.exist?(file)
    end

    Hanami.logger.warn "Could not find downloaded file #{filename}"
  end
end