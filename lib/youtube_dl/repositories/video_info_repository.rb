class VideoInfoRepository < Hanami::Repository
  def find_by_video(video_id)
    video_infos.where(video_id: video_id)
  end
end
