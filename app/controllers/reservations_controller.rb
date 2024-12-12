class ReservationsController < ApplicationController
  before_action :set_store, only: [:index, :show]

  def index
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

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:rsv_date, :rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(store_id: params[:store_id])
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

end
