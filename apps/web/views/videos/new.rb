module Web
  module Views
    module Videos
      class New
        include Web::View

        def locations
          repo = LocationRepository.new
          Hash[repo.all.map {|loc| [loc.label, loc.id]}]
        end
      end
    end
  end
end
