class StoresController < ApplicationController
  before_action :authenticate_user! #, except: []
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.where(user_id: current_user.id)
  end

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
  
  def show
  end

  def edit
  end

  def update
    if @store.update(store_params)
      redirect_to store_path(@store.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # 「本当に削除しますか？」の確認を追加したい！JavaScriptで
    @store.destroy
    redirect_to root_path
  end


  private

  def store_params
    params.require(:store).permit(:store_name, :store_guide,
      :store_address, :store_tel).merge(user_id: current_user.id)
  end
  
  def set_store
    @store = Store.find(params[:id])
  end

end
