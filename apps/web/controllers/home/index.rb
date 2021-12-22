module Web
  module Controllers
    module Home
      class Index
        include Web::Action

        def call(params)
          redirect_to routes.videos_path
        end
      end
    end
  end
end
