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
          videos.select {|x| VideoState.active?(x.state) }
        end

        def pending
          videos.select {|x| VideoState.pending?(x.state) }
        end

        def error
          videos.select {|x| VideoState.error?(x.state) }
        end

        def completed
          videos.select {|x| VideoState.completed?(x.state) }
        end

        def deleted
          videos.select {|x| VideoState.deleted?(x.state) }
        end

        def unknown
          videos.reject {|x| known?(x.state) }
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
