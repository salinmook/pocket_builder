class ApplicationController < ActionController::Base
  before_action :set_store

  helper_method :current_store
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private
  def set_store
    if params[:store_id]
      session[:store_id] = params[:store_id]
    elsif params[:id] && controller_name == "stores"
      session[:store_id] = params[:id]
    end
    @current_store = Store.find_by(id: session[:store_id])
  end

  def current_store
    @current_store ||= Store.find_by(id:session[:store_id])
  end
end
