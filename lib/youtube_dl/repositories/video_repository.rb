class VideoRepository < Hanami::Repository
  associations do
    belongs_to :location
  end

  def find_with_location(id)
    aggregate(:location).where(id: id).map_to(Video).one
  end

  def find_by_url(url)
    videos.where(url: url).first
  end
end
