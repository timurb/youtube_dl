module Web
  module Controllers
    module Videos
      class Index
        include Web::Action

        expose :videos

        def call(params)
          repo = VideoRepository.new
          ids = repo.all.map(&:id)
          @videos = ids.map { |id| repo.find_with_location(id) }
        end
      end
    end
  end
end
