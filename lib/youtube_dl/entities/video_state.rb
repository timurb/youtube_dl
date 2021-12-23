class VideoState
  include Ruby::Enum

  define :created, 0
  define :processing, 1
  define :done, 2
  define :deleted, 3
  define :error, 4
  define :restarted, 5
end
