class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_nda
    if current_user && !current_user.nda_signed
      return redirect_to :controller => "nda", :action => "index"
    end
  end
  
  def require_admin
    if !current_user || !current_user.admin
      flash[:alert] = "You must be loggedin as an admin to access this feature"
      return redirect_to(root_path)
    end
  end
end
