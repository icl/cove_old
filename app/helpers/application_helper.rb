module ApplicationHelper
  def display_flash
    html = ""
    if flash[:alert]
      html << %[<div class="grid_16 flash alert">#{flash[:alert]}</div>]
    end
    if flash[:notice]
      html << %[<div class="grid_16 flash notice">#{flash[:notice]}</div>]
    end
    return raw(html)
  end
end
