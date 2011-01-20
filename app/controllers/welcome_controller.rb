class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      require_nda
    end
  end

end
