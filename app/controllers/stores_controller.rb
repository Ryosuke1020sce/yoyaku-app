class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def store_params
    params.require(:store).permit(:store_name, :store_guide,
      :store_address, :store_tel).merge(user_id: current_user.id)
  end

end
