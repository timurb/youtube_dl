class VideoRepository < Hanami::Repository
  associations do
    belongs_to :location
    has_one :video_info
  end

  def find_with_location(id)
    aggregate(:location).where(id: id).map_to(Video).one
  end

  def find_by_url(url)
    videos.where(url: url).first
  end

  def create_with_video_info(data)
    assoc(:video_info).create(data)
  end

  def add_video_info(video, data)
    assoc(:video_info, video).add(data)
  end

  def update_video_info(video, data)
    assoc(:video_info, video).update(data)
  end
end
