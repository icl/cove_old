Factory.define :interval, :class => Interval do |f|
  f.filename "test_video.mov"
  f.camera_angle "balcony"
  f.session_number "2"
  f.start_time 5.weeks.ago
  f.duration 5.minutes.to_i
  f.session_type "practice"
  f.phrase_name "foo"
  f.task_name "bar"
end