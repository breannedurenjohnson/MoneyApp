class LoansController < ApplicationController
    before_action :require_lender_login
    def create
        @lender = Lender.find_by(id: session[:lender_id])
        @borrower = Borrower.find_by(id: params[:borrower_id])
        if @borrower
            @loan = Loan.new(loan_params)
            if @loan.invalid?
                flash[:errors] = [@loan.errors.full_messages]
            elsif @loan.amount > @lender.money
                flash[:errors] = "Insufficient funds"
            else 
                @lender.money -= @loan.amount
                @borrower.amount_raised += @loan.amount
                @borrower.save
                @loan.save
                @lender.save
            end
        end
        redirect_to lenders_path
    end
    private
    def loan_params
        params.require(:loan).permit(:amount).merge(lender: @lender, borrower: @borrower)
    end

    def require_lender_login
        if session[:lender_id] == nil
            redirect_to login_path
        end
    end
end
