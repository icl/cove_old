Factory.define :tag, :class => Tag do |f|
  f.description "This is a test tag."
  f.name "Test"
end

Factory.define :tagging, :class => Tagging do |f|
  f.name "Test"
  f.interval do
    if Interval.first
      Interval.first
    else
      Factory :interval
    end
  end

  f.user do
    if User.first
      User.first
    else
      Factory :regular_user
    end
  end
end

