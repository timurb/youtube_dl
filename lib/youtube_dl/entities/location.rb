class Location < Hanami::Entity
  def full_path
    File.join(base_path, path)
  end

  private

  def base_path
    YoutubeDl::Config.new.base_path
  end
end
