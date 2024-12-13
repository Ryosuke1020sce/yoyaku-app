class RsvGroupsController < ApplicationController

  def new
    @reservation = Reservation.new
  end

  def create
    
    today_y = params[:reservation][:today_y]
    today_m = params[:reservation][:today_m]    
    n = params[:reservation][:last_i]

    rsv_group = RsvGroup.new
    save_success = false

    n.times do |i|
      d_sym = "day_#{i}".to_sym
      if params[d_sym] == 1 
        @reservation = Reservation.new(reservation_params)
        if !@reservation.save
          render :new, status: :unprocessable_entity
        else
          save_success = true
        end
      end
    end    

    if save_success
      redirect_to store_reservations_path(params[:reservation][:store_id])
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:rsv_date, :rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(store_id: params[:store_id], rsv_group_id: rsv_group.id)
  end

end
