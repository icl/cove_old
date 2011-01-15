class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_nda
    if !current_user.nda_signed
      return redirect_to :controller => "nda", :action => "index"
    end
  end
end
