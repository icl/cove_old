module ApplicationHelper
  def display_flash
    html = ""
    if flash[:alert]
      html << "<div class='flash alert'>#{flash[:alert]}</div>"
    end
    if flash[:notice]
      html << "<div class='flash notice'>#{flash[:notice]}</div>"
    end
    return raw(html)
  end
  def add_params params_to_add
	  new_p = params.dup
	  new_p.delete(:page)
	  new_p.delete(:auth)
	  new_p.delete(:action)
	  new_p.delete(:controller)
	  new_p.merge! params_to_add
	  new_p.to_hash
  end
end
