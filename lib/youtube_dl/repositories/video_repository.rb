class VideoRepository < Hanami::Repository
  associations do
    belongs_to :location
  end
end
