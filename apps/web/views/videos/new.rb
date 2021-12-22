module Web
  module Views
    module Videos
      class New
        include Web::View
        def locations
          LocationRepository.new
        end
      end
    end
  end
end
