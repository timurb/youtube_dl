class Location < Hanami::Entity
  def full_path
    if (Pathname.new path).absolute?
      path
    else
      File.join(YoutubeDl::Config.new.base_path, path)
    end
  end

  def label
    name || full_path
  end
end
