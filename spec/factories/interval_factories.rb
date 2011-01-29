Factory.define :interval, :class => Interval do |f|
  f.filename "/some/random/file"
  f.camera_angle "balcony"
  f.session_number "2"
  f.start_time 5.weeks.ago
  f.end_time 5.weeks.ago().advance(:mins => 5)
  f.session_type "practice"
  f.phrase_name "foo"
  f.task_name "bar"
end