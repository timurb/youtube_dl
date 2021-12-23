require "open3"

class YoutubeDlWorker
  include Sidekiq::Worker

  def perform(arg)
    repo = VideoRepository.new
    location = LocationRepository.new
    video = repo.find_with_location(arg["id"])

    if video.state_const == VideoState.created
      Hanami.logger.info "Video #{video.url} state is #{video.state_const}. Download skipped"
    else

      repo.update(video.id, state: VideoState.processing)
      if download_video(video.url, video.location.path).exitstatus == 0
        repo.update(video.id, state: VideoState.done)
        Hanami.logger.info "Finished downloading video #{video.url} to #{video.location.path}"
      else
        repo.update(video.id, state: VideoState.error)
        Hanami.logger.error "Error downloading video #{video.url}"
      end
    end
  end

  def download_video(video, location)
    Hanami.logger.info "Downloading video #{video} to #{location}"
    stdin, stdout, stderr, wait_thr = Open3.popen3("youtube-dl #{video}")
    exit_status = wait_thr.value
    puts "Exit status: #{exit_status}"
    puts stdout.read, stderr.read
    exit_status
  end
end