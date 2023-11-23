class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    cart_item = CartItem.new(cart_item_params)
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      flash[:notice] = "カートに追加しました。"
      redirect_to cart_items_path
    elsif
      cart_item.save
      flash[:notice] = "カートに追加しました。"
      redirect_to cart_items_path
    else
      flash[:alert] = "個数を入力してください。"
      redirect_to item_path(cart_item.item.id)
    end
  end

  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    flash[:notice] = "数量を変更しました。"
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    flash[:notice] = "カートを空にしました。"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
