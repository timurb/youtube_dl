module Web
  module Views
    module Videos
      class Index
        include Web::View

        def videos
          repo = VideoRepository.new
          ids = repo.all.map(&:id)
          ids.map { |id| repo.find_with_location(id) }
        end

        def active
          videos.select {|x| VideoState.active?(x.state_id) }
        end

        def pending
          videos.select {|x| p x; VideoState.pending?(x.state_id) }
        end

        def error
          videos.select {|x| VideoState.error?(x.state_id) }
        end

        def completed
          videos.select {|x| VideoState.completed?(x.state_id) }
        end

        def deleted
          videos.select {|x| VideoState.deleted?(x.state_id) }
        end

        def unknown
          videos.reject {|x| known?(x.state_id) }
        end

        def known?(state)
          VideoState.pending?(state) ||
          VideoState.active?(state) ||
          VideoState.error?(state) ||
          VideoState.completed?(state) ||
          VideoState.deleted?(state)
        end

      end
    end
  end
end
