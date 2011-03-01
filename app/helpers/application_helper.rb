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
  def add_params params_to_add={}
	  new_p = params.dup
	  new_p.delete(:page)
	  new_p.delete(:auth)
	  new_p.delete(:action)
	  new_p.delete(:controller)
	  new_p.merge! params_to_add
	  new_p.to_hash
  end
  def gravatar_url_for email 
    hash = Digest::MD5.hexdigest(email)
    image_src = "http://www.gravatar.com/avatar/#{hash}"
  end

  def display_coding_term(applied=[], all=[])
    html = "<ul>"
    applied.each do |term|
      if all.delete(term.code)
        html << %Q[<li class="code applied" data-codingType="#{term.code.coding_type}" data-rails_object_id="#{term.code.id}"> #{term.code.name} </li>]
      end
    end
    all.each do |term|
      html << %Q[<li class="code unapplied" data-codingType= "#{term.coding_type}" data-rails_object_id="#{term.id}"> #{term.name} </li>]
    end
    html << "</ul>"
    return html.html_safe
  end
end
