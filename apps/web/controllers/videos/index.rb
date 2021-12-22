module Web
  module Controllers
    module Videos
      class Index
        include Web::Action

        expose :videos

        def call(params)
          @videos = VideoRepository.new.all
        end
      end
    end
  end
end
