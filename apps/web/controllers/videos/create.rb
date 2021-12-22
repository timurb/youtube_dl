module Web
  module Controllers
    module Videos
      class Create
        include Web::Action

        expose :video

        params do
          required(:video).schema do
            required(:url).filled(:str?)
          end
        end

        def call(params)
          if params.valid?
            params[:video][:status] = 'new'
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
