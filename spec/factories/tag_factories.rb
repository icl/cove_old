Factory.define :tag, :class => Tag do |f|
  f.name "Test"
end

Factory.define :taging, :class => Taging do |f|
  f.association :user, :factory => :regular_user
  f.association :interval, :factory => :interval
  f.association :tag, :factory => :tag
end