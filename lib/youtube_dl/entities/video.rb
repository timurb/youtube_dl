class Video < Hanami::Entity
  def location_id
    location.id if location
  end

  def location_path
    location.path if location
  end

  def location_full_path
    location.full_path if location
  end

  def state_text
    VideoState.key(state_id)
  end
end
