class VideoInfo < Hanami::Entity
  class << self
    def create_from_youtube(json)
      self.new(
        youtube_id: json['id'],

        title: json['title'],
        thumbnail: json['thumbnail'],
        description: json['description'],
        duration: json['duration'],
        filename: json['_filename'],

        uploader: json['uploader'],
        uploader_url: json['uploader_url'],
        channel: json['channel'],
        channel_url: json['channel_url'],
      )
    end
  end
end
