class Snippet < ActiveRecord::Base
  validates_presence_of :offset, :duration
  belongs_to :interval

  def offset_s
    return time_to_string @offset
  end

  def end_time_s
    return time_to_string @offset + @duration
  end

  def time_to_string(t)
    deciseconds = (t / 100 % 100).round
    seconds = (t % 60).floor
    hours = (t / 60).floor
    return "%02d:%02d.%02d" % [hours, seconds, deciseconds]
  end
end
