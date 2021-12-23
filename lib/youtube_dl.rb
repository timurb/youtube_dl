module YoutubeDl
  class Config < Anyway::Config
    attr_config(
      base_path: File.expand_path(File.join(__FILE__, '../..')),
      session_secret: nil
    )
  end
end
