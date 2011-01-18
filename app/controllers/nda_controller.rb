class NdaController < ApplicationController
  # method responds to GET and renders the index template
  def index
    render "index"
  end
  
  def create
    if params[:accept].to_i == 1
      current_user.nda_signed = true
      current_user.nda_signature_date = DateTime.now
      current_user.save
      return redirect_to(root_path)
    else
      flash[:alert] = "You must accept NDA to continue"
      return redirect_to :action => "index"
    end
  end
end
