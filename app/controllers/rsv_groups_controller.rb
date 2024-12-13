class RsvGroupsController < ApplicationController

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

  private

  def reservation_params(this_day)
    params.require(:reservation).permit(:rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(rsv_date: this_day,
      store_id: params[:store_id], rsv_group_id: @rsv_group.id)
  end

end
