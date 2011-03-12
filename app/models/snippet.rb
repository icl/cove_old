class Snippet < ActiveRecord::Base
  validates_presence_of :offset, :duration
  belongs_to :interval

  attr_accessor :start_time
  attr_accessor :end_time

  def start_time=(time_string)
    offset = string_to_seconds time_string rescue nil
  end

  def start_time
    seconds_to_string offset rescue nil
  end

  def end_time=(time_string)
    duration = (string_to_seconds time_string) - offset rescue nil
  end

  def end_time
    seconds_to_string (offset + duration) rescue nil
  end

  def seconds_to_string(t)
    centiseconds = (t / 100 % 100).round
    seconds = (t % 60).floor
    minutes = (t / 60).floor
    return "%02d:%02d.%02d" % [minutes, seconds, centiseconds]
  end
end
