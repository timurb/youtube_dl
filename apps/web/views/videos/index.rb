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
          videos.select {|x| VideoState.pending?(x.state_id) }
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

        def info_for(video)
          repo = VideoRepository.new
          info = repo.find_with_info(video.id).video_info
        end

        def thumbnail_for(video)
          res = info_for(video)
          res.thumbnail if res
        end

        def title_for(video)
          res = info_for(video)
          res.title if res
        end

        def known?(state)
          VideoState.pending?(state) ||
          VideoState.active?(state) ||
          VideoState.error?(state) ||
          VideoState.completed?(state) ||
          VideoState.deleted?(state)
        end

        def job_running?(id)
          YoutubeDlWorker.new.running?(id)
        end
      end
    end
  end
end
