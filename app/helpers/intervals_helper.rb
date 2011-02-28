module IntervalsHelper
  
  def image_for_camera_angle angle
    case angle
      when /Daily 2/
        image_tag "daily2.png"
      when /Mirror/
        image_tag "mirror.png"
      when /Daily 1/
        image_tag "daily1.png"
      when /Rear 2/
        image_tag "rear2.png"
      when /Wayne/
        image_tag "wayne.png"
      when /Rear 1/
        image_tag "rear1.png"
      else
	nil
    end
  end
end
