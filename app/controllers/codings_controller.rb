class CodingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_nda
  respond_to :html, :json
  def create
    @interval = Interval.find(params[:interval_id])
    @new_coding = Coding.new(params[:coding])
    @new_coding.interval = @interval
    @new_coding.user = current_user
    if @new_coding.save
      respond_with do |format|
        format.html {redirect_to interval_path(params[:interval_id])}
        format.json do
          render :json => {"status" => "success", 
            "codeName" => @new_coding.code.name, 
            "codeID" => @new_coding.code.id,
            "codeType" => @new_coding.code.coding_type,
            "coding" => @new_coding.to_json}, :status => 201
        end
      end
    else
      respond_with do |format|
        format.html {redirect_to interval_path(params[:interval_id])}
        format.json do
          render :json => {"status" => "failure"}, :status => 422
        end
      end
    end
  end

  def show
    @code = Coding.find(params[:id])
    respond_with(@code)  
  end
end
