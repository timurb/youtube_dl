require 'uri'

module Web
  module Controllers
    module Videos
      class Create
        include Web::Action

        expose :video

        params do
          required(:video).schema do
            required(:location_id) {
              filled?
            }

            required(:url) {
              format?(URI.regexp(%w(http https)))
            }

          end
        end

        def call(params)
          if params.valid?
            repository = VideoRepository.new

            video = params[:video]
            found = repository.find_by_url(params[:video][:url])

            if found
              @video = repository.update(found.id, state: VideoState.restarted)
            else
              video[:state] = VideoState.created
              @video = repository.create(video)
            end

            video[:id] = @video.id
            YoutubeDlWorker.perform_async(id: video[:id], url: video[:url])
            redirect_to routes.videos_path
          else
            self.status = 422
          end
        end

      end
    end
  end
end
