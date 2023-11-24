class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "変更しました。"
      redirect_to customers_mypage_path
    else
      flash.now[:alert] = "変更に失敗しました。入力内容を確認してください。"
      render :edit
    end
  end

  def withdraw
  end

  def unsubscribe
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
