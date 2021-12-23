module Web
  module Controllers
    module Videos
      class Index
        include Web::Action

        expose :videos, :pending, :active, :error, :completed, :unknown

        def call(params)
          repo = VideoRepository.new
          ids = repo.all.map(&:id)
          @videos = ids.map { |id| repo.find_with_location(id) }
          @pending = @videos.select {|x| pending_states.include? x.state }
          @active = @videos.select {|x| active_states.include? x.state }
          @error = @videos.select {|x| error_states.include? x.state }
          @completed = @videos.select {|x| completed_states.include? x.state }
          @deleted = @videos.select {|x| deleted_states.include? x.state }
          @unknown = @videos.reject {|x| known_states.include? x.state }
        end

        def pending_states
          [ VideoState.created, VideoState.restarted ]
        end

        def active_states
          [ VideoState.processing ]
        end

        def error_states
          [ VideoState.error ]
        end

        def completed_states
          [ VideoState.done ]
        end

        def deleted_states
          [ VideoState.deleted ]
        end

        def known_states
          (pending_states + active_states + error_states + completed_states + deleted_states).uniq
        end
      end
    end
  end
end
