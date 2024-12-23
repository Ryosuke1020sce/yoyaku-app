class StoresController < ApplicationController
  before_action :authenticate_user! #, except: []
  before_action :set_store, only: [:show, :edit, :update, :destroy, :new_copy]

  def index
    @stores = Store.where(user_id: current_user.id)
  end

  def new
    @store = Store.new
  end

  def new_copy
  end

  def create_copy
    @store = Store.new(store_params)
    if @store.save
      redirect_to root_path
    else
      render :new_copy, status: :unprocessable_entity
    end
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
    @calendar = Calendar.new
    @calendars = Calendar.where(store_id: params[:id])
    check_calendar
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

  def select_month
    @store = Store.find(params[:store_id])
    @calendars = Calendar.where(store_id: @store.id)
  end

  private

  def store_params
    params.require(:store).permit(:store_name, :store_guide,
      :store_address, :store_tel, :image).merge(user_id: current_user.id)
  end
  
  def set_store
    @store = Store.find(params[:id])
  end
  
  def next_month(m)
    if m == 12
      return 1
    else
      return m + 1
    end
  end

  def next_year(y, m)
    if m == 12
      return y + 1
    else
      return y
    end
  end

  def check_calendar

    today = Date.today
    today_m = today.month
    today_y = today.year
    d1 = Date.new(today_y, today_m, 1)
    next_y_1 = next_year(today_y, today_m) 
    next_m_1 = next_month(today_m)
    d2 = Date.new(next_y_1, next_m_1, 1)
    next_y_2 = next_year(next_y_1, next_m_1) 
    next_m_2 = next_month(next_m_1)
    d3 = Date.new(next_y_2, next_m_2, 1)

    boo1 = (Calendar.where(store_id: @store.id, std_date: d1).count != 0)
    boo2 = (Calendar.where(store_id: @store.id, std_date: d2).count != 0)
    boo3 = (Calendar.where(store_id: @store.id, std_date: d3).count != 0)

    if !boo1
      Calendar.create(std_date: d1, store_id: @store.id)
    end  

    if !boo2
      Calendar.create(std_date: d2, store_id: @store.id)
    end  

    if !boo3
      Calendar.create(std_date: d3, store_id: @store.id)
    end  

  end

end
