class Snippet < ActiveRecord::Base
  validates_presence_of :offset
  belongs_to :interval

  attr_accessor :start_time, :end_time

  before_validation :read_start_end_times
  after_find :write_start_end_times
  
  def read_start_end_times
    self.offset = (string_to_seconds self.start_time) rescue nil
    self.duration = (string_to_seconds self.end_time) - self.offset rescue nil
    true
  end

  def write_start_end_times
    self.start_time = seconds_to_string self.offset rescue nil
    self.end_time = seconds_to_string (self.offset + self.duration) rescue nil
    true
  end

  def duration_s
    sec = self.duration
    if (sec.nil?)
      "none"
    else
      "%.2dh%.2dm%.2ds" % [(sec/360).floor, (sec/60%360).floor, (sec%60).round]
    end
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
