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
    @orders.order_items.build

    @cart_items = CartItem.all
    @customer = current_customer
    @total = 0
    @postage = 800
    @claim = 0
  end

  def create
    order = Order.new(order_params)
    order.save

    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.item_id = cart_item.item.id
      @order_items.order_id = order.id
      @order_items.tax_included_price = cart_item.item.add_tax_price
      @order_items.amount = cart_item.amount
      @order_items.save!
    end

    CartItem.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    @customer = current_customer
    @orders = @customer.orders
    @claim = 0
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_post_code, :shipping_address, :shipping_name, :payment_method, :item_total_amount, :postage)
  end
end
