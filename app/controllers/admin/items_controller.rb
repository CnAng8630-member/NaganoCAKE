class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "登録しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください"
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "変更しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "変更に失敗しました。入力内容を確認してください。"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end
end
