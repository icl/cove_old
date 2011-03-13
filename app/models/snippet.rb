class Snippet < ActiveRecord::Base
  validates_presence_of :offset, :duration
  belongs_to :interval

  attr_accessor :start_time
  attr_accessor :end_time

  def start_time=(time_string)
    write_attribute :offset, string_to_seconds(time_string)
  end

  def start_time
    seconds_to_string offset rescue nil
  end

  def end_time=(time_string)
    write_attribute :duration, string_to_seconds(time_string)
  end

  def end_time
    seconds_to_string(duration) rescue nil
  end

  def string_to_seconds(s)
    min_sec = s.split(":")
    case min_sec.length
    when 1
      min_sec[0].to_f
    when 2
      60 * min_sec[0].to_f + min_sec[1].to_f
    else
      nil
    end
  end

  def seconds_to_string(t)
    centiseconds = (t / 100 % 100).round
    seconds = (t % 60).floor
    minutes = (t / 60).floor
    return "%02d:%02d.%02d" % [minutes, seconds, centiseconds]
  end
end
