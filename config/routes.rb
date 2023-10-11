Rails.application.routes.draw do
  namespace :public do
    get 'orders/new'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/withdraw'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  namespace :admin do
    root to: 'homes#top'
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
