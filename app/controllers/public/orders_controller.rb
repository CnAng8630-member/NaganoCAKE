class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @customer = current_customer
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end
end
