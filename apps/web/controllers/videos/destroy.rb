module Web
  module Controllers
    module Videos
      class Destroy
        include Web::Action

        def call(params)
          if params.valid?
            repository = VideoRepository.new

            video = repository.find_with_info(params[:id])
            ::File.delete(video.filename) if video.filename
            repository.update(video.id, state_id: VideoState.deleted)

            redirect_to routes.videos_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end
