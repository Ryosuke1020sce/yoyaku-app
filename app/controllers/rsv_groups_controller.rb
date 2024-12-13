class RsvGroupsController < ApplicationController
  before_action :set_store, only: [:new, :edit, :update]
  before_action :set_rsv_group, only: [:edit, :update]

  def new
    @reservation = Reservation.new
  end

  def create
 
    y = params[:reservation][:today_y].to_i
    m = params[:reservation][:today_m].to_i
    n = params[:reservation][:last_i].to_i

    @rsv_group = RsvGroup.create(store_id: params[:store_id])
    save_successed = false

    n.times do |i|
      d_sym = "day_#{i}".to_sym
      if params[:reservation][d_sym] == "1" 
        this_day = Date.new(y, m, i+1)
        @reservation = Reservation.new(reservation_params(this_day))
        if !@reservation.save
          render :new, status: :unprocessable_entity
        else
          save_successed = true
        end
      end
    end    

    if save_successed
      redirect_to store_reservations_path(params[:store_id])
    end

  end

  def edit
    @reservations = Reservation.where(rsv_group_id: @rsv_group)
  end

  def update

    n = params[:reservation][:last_i].to_i + 1
    save_successed = false
    
    @reservations = Reservation.where(rsv_group_id: @rsv_group)

    @reservations.each do |rsv|
      d = rsv.rsv_date
      if rsv.update(reservation_params(d))
        save_successed = true
      else
        render :edit, status: :unprocessable_entity
      end
    end

    if save_successed
      redirect_to store_reservations_path(@store.id)
    end
  end

  private

  def reservation_params(this_day)
    params.require(:reservation).permit(:rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(rsv_date: this_day,
      store_id: params[:store_id], rsv_group_id: @rsv_group.id)
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_rsv_group
    @rsv_group = RsvGroup.find(params[:id])
  end

end
