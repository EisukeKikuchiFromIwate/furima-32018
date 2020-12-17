class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    return redirect_to user_session_path unless user_signed_in?

    redirect_to action: :index unless @item.user_id == current_user.id
    unless @item.order.blank?
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,
                                 :name,
                                 :info,
                                 :category_id,
                                 :status_id,
                                 :shipping_fee_status_id,
                                 :prefecture_id,
                                 :scheduled_delivery_id,
                                 :price)
          .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
