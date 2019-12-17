class SessionsController < ApplicationController
    before_action :require_lender_login, only: [:lender_destroy]
    before_action :require_borrower_login, only: [:borrower_destroy]
    def new 
    end
    def create
        @lender = Lender.find_by_email(params[:email])
        if @lender != nil
            if @lender.try(:authenticate, params[:password]) == false
                flash[:errors] = "Invalid Combination"
                redirect_to login_path
            else
                session[:lender_id] = @lender.id
                redirect_to lenders_path
            end
        else
            @borrower = Borrower.find_by_email(params[:email])
            if @borrower != nil
                if @borrower.try(:authenticate, params[:password]) == false
                    flash[:errors] = "Invalid Combination"
                    redirect_to login_path
                else
                    session[:borrower_id] = @borrower.id
                    redirect_to borrowers_path
                end
            else 
            flash[:errors] = "Account does not exist"
            redirect_to login_path
            end
        end
    end
    def lender_destroy
        session[:lender_id] = nil
        redirect_to register_path
    end
    def borrower_destroy
        session[:borrower_id] = nil
        redirect_to register_path
    end

    private
    def require_lender_login
        if session[:lender_id] == nil
            redirect_to login_path
        end
    end
    def require_borrower_login
        if session[:borrower_id] == nil
            redirect_to login_path
        end
    end
end