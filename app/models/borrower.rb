class Borrower < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :need_money_for, :description, :amount_needed, presence: true
  validates :first_name, :last_name, :need_money_for, :description, length: {minimum: 2}
  validates :amount_needed, numericality: { greater_than_or_equal_to: 0 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :password, length: {minimum: 8, maximum: 72}, on: :create
  before_save :downcase_email
  has_many :loans, dependent: :destroy
  has_many :lenders_who_gave, through: :loans, source: :lender

  private
  def downcase_email
    self.email.downcase!
  end
end
