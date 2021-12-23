module Web
  module Views
    module Videos
      class Create
        include Web::View
        template 'videos/new'

        def locations
          repo = LocationRepository.new
          Hash[repo.all.map {|loc| [loc.path, loc.id]}]
        end
      end
    end
  end
end
