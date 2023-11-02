class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_post_code = current_customer.postal_code
    @order.shipping_address = current_customer.address
    @order.shipping_name = current_customer.last_name + current_customer.first_name

    @orders = Order.new
    @order_item = OrderItem.new

    @cart_items = CartItem.all
    @customer = current_customer
    @total = 0
    @postage = 800
    @claim = 0
  end

  def create
    order = Order.new(order_params)
    order.save
    order_item = OrderItem.new(order_item_params)
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_post_code, :shipping_address, :shipping_name, :payment_method, :item_total_amount, :postage)
  end

  def order_item_params
    params.require(:order_item).permit(:item_id, :order_id, :tax_included_price, :amount)
  end
end
