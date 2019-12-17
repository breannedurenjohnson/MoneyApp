Rails.application.routes.draw do
  get "register" => "lenders#new"
  post "lenders/new" => "lenders#create"
  post "borrowers/new" => "borrowers#create"
  get "lenders" => "lenders#show"
  get "borrowers" => "borrowers#show"
  get "login" => "sessions#new"
  post "sessions/new" => "sessions#create"
  post "loans/:borrower_id" => "loans#create"
  delete "sessions/destroy/lender" => "sessions#lender_destroy"
  delete "sessions/destroy/borrower" => "sessions#borrower_destroy"

  match '*path' => redirect('/login'), via: :get
end
