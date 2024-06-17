class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  rescue_from ::CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_url, flash: { error: exception.message } }
      format.js { head :forbidden, content_type: "text/html" }
    end
  end
end
