module Web
  module Controllers
    module Videos
      class Update
        include Web::Action
        include Hanami::Validations

        predicate :valid_state?, message: 'must be an URL' do |current|
          VideoState.value(current)
        end
        validations do
          required(:video).schema do
            required(:state) {
              valid_state?
            }
          end
        end

        def call(params)
          if params.valid?
            repository = VideoRepository.new

            state =  VideoState.value(params.get(:video, :state).to_sym)
            video = repository.update(params[:id], state_id: state)
            YoutubeDlWorker.perform_async(id: video.id, url: video.url)

            redirect_to routes.videos_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end
