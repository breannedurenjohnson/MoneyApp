class LendersController < ApplicationController
    before_action :require_lender_login, only: [:show]
    def new
    end
    def create
        @lender = Lender.new(lender_params)
        if @lender.valid?
            @lender.save
            session[:lender_id] = @lender.id
            redirect_to lenders_path
        else
            flash[:errors] = @lender.errors.full_messages
            redirect_to register_path
        end
    end
    def show
        @lender = Lender.find_by(id: session[:lender_id])
        @borrowers_lended = @lender.borrowers_lended_to.group(:id)
        @borrowers = Borrower.all
    end
    private
    def lender_params
        params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
    end
    def require_lender_login
        if session[:lender_id] == nil
            redirect_to login_path
        end
    end
end
