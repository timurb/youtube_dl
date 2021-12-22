class Video < Hanami::Entity
  def location_id
    location.id
  end

  def location_path
    location.path if location
  end
end
