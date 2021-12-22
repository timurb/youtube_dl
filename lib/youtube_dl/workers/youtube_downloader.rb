class YoutubeDlWorker
  include Sidekiq::Worker

  def perform(arg)
    repo = VideoRepository.new
    location = LocationRepository.new
    video = repo.find_with_location(arg["id"])

    if video.state_const == VideoState.created
      puts "Video #{video.url} state is #{video.state_const}. Download skipped"
    else
      puts "Downloading video #{video.url} to #{video.location.path}"

      repo.update(video.id, state: VideoState.processing)
      download_video(video)
      repo.update(video.id, state: VideoState.done)
      puts "Finished downloading video #{video.url} to #{video.location.path}"
    end
  end

  def download_video(video)
    puts "Piu Piu #{video}"
  end
end