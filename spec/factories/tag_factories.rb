Factory.define :tag, :class => Tag do |f|
  f.name "Test"
end

Factory.define :taging, :class => Taging do |f|
  f.user_id 1
  f.interval_id 1
  f.tag_id 1
end