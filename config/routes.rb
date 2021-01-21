Rails.application.routes.draw do
  root 'documents#new'
  resources :documents, only: [:new, :create] do
    post 'add_sign_to_pdf', on: :member
    get 'signed_document', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
