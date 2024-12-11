class ReservationsController < ApplicationController

  def index
    @store = Store.find(params[:store_id])
    @reservations = Reservation.where(store_id: params[:store_id])
  end

  def new
    @reservation = Reservation.new
  end

  def create

    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to store_reservations_path(params[:store_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:rsv_date, :rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(store_id: params[:store_id])
  end

end
