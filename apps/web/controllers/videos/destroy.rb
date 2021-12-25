module Web
  module Controllers
    module Videos
      class Destroy
        include Web::Action

        def call(params)
          if params.valid?
            repository = VideoRepository.new
            info_repository = VideoInfoRepository.new

            video = repository.find_with_location(params[:id])
            Dir.chdir(video.location.full_path)

            info = info_repository.find_by_video(video.id).first

            if info && info.filename
              Hanami.logger.info "Deleting #{info.filename} from #{video.location.full_path}"
              ::File.delete(info.filename) if info.filename
            else
              Hanami.logger.info "No video info available for video #{video.id}"
            end
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
