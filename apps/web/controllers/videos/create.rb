require 'uri'

module Web
  module Controllers
    module Videos
      class Create
        include Web::Action

        expose :video

        params do
          required(:video).schema do
            required(:url) {
              format?(URI.regexp(%w(http https)))
            }

            required(:location_id) {
              filled?
            }
          end
        end

        def call(params)
          if params.valid?
            params[:video][:state] = VideoState.created
            video = Video.new(params[:video])

            repository = VideoRepository.new
            @video = repository.create(video)

            redirect_to routes.videos_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end
