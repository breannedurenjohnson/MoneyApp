class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  def current_lender_user
    Lender.find(session[:lender_id]) if session[:lender_id]
  end
  helper_method :current_lender_user
  
  def current_borrower_user
    Borrower.find(session[:borrower_id]) if session[:borrower_id]
  end
  helper_method :current_borrower_user


end
