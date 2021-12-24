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
      [ VideoState.processing ].include?(state) ||
        [ VideoState.processing ].include?(value(state))
    end

    def pending?(state)
      [ VideoState.created, VideoState.restarted ].include?(state) ||
        [ VideoState.created, VideoState.restarted ].include?(value(state))
    end

    def error?(state)
      [ VideoState.error ].include?(state) ||
        [ VideoState.error ].include?(value(state))
    end

    def completed?(state)
      [ VideoState.done ].include?(state) ||
        [ VideoState.done ].include?(value(state))
    end

    def deleted?(state)
      [ VideoState.deleted ].include?(state)
        [ VideoState.deleted ].include?(value(state))
    end
  end
end
