class BorrowersController < ApplicationController
    before_action :require_borrower_login, only: [:show]
    def create
        @borrower = Borrower.new(borrower_params)
        if @borrower.valid?
            @borrower.amount_raised = 0
            @borrower.save
            session[:borrower_id] = @borrower.id
            redirect_to borrowers_path
        else
            flash[:errors] = @borrower.errors.full_messages
            redirect_to register_path
        end
    end
    def show
        @borrower = Borrower.find_by(id: session[:borrower_id])
        @lenders = @borrower.lenders_who_gave.group(:id)
    end
    private
    def borrower_params
        params.require(:borrower).permit(:first_name, :last_name, :email, :password, :need_money_for, :description, :amount_needed, :amount_raised)
    end
    def require_borrower_login
        if session[:borrower_id] == nil
            redirect_to login_path
        end
    end
end
