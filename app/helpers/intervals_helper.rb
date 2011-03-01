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
  
  def insert_thumbnail_imagemap name
          html = %Q[<map name=thumbmap_#{name}>]
          first=0
          second=1
          for i in 1..160
              #html << %Q[<area shape ="rect" coords ="#{first.to_s},0,#{second.to_s},90" onMouseOver="swapThumb(this)" class="thumb_scrub" id="thumb#{i.to_s}" title="#{name}"/>];
              html << %Q[<area shape ="rect" coords ="#{first.to_s},0,#{second.to_s},90" class="thumb_scrub" id="thumb#{i.to_s}" title="#{name}"/>];
              first=second
              second+=1
          end
          html << %Q[</map>]
          return raw html
  end
end
