class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:user_id]
      items = find_user_items
    else
      items = Item.all
    end
      render json: items, include: :user
   
  end

  def show 
      item = Item.find params[:id]
      render json: item, include: :user
  end

  def create
    item = find_user_items.create(item_params)
    render json: item, status: :created

  end

  private 

  def find_user_items
    User.find(params[:user_id]).items
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def not_found
    render json: {error: "invalid" } , status: 404
  end

end
