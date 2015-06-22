class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def recent_paper_ids
    session[:recent_paper_ids] || []
  end

  def recent_papers
    recent_paper_ids.map {|id| Paper.find(id) }
  end
end
