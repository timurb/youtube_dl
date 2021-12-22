class Video < Hanami::Entity
  def location_id
    location.id if location
  end

  def location_path
    location.path if location
  end

  def path_for
    "#{location_path}/#{filename}"    ###FIXME
  end

  def state_const
    VideoState.key(state)
  end
end
