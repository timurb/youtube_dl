class VideoState
  include Ruby::Enum

  define :created, 0
  define :processing, 1
  define :done, 2
  define :deleted, 3
  define :error, 4
  define :restarted, 5

  class << self
    def active?(state)
      [ VideoState.processing ].include? state
    end

    def pending?(state)
      [ VideoState.created, VideoState.restarted ].include? state
    end

    def error?(state)
      [ VideoState.error ].include? state
    end

    def completed?(state)
      [ VideoState.done ].include? state
    end

    def deleted?(state)
      [ VideoState.deleted ].include? state
    end
  end
end
