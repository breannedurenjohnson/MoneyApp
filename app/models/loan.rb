class Loan < ApplicationRecord
  belongs_to :lender
  belongs_to :borrower
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
