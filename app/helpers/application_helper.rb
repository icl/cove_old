module ApplicationHelper
  def display_flash
    html = ""
    if flash[:alert]
      html << "<div class='flash alert'><%= flash[:error] %> </div>"
    end
    if flash[:notice]
      html << "<div class='flash notice'><%= flash[:notice] %> </div>"
    end
    return html
  end
end
