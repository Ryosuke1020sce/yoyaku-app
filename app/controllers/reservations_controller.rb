class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def new
    @reservation = Reservation.new
    today = Date.today
    y = today.year
    m = today.month
    std_date = Date.new(y,m,1)
    search_calendar(std_date)
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
    @guest = Guest.new
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      search_calendar(@reservation.rsv_date)
      redirect_to store_calendar_path(@store.id, @calendar.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    search_calendar(@reservation.rsv_date)
    redirect_to store_calendar_path(@store.id, @calendar.id)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:rsv_date, :rsv_time_id, :rsv_n, :explain,
      :service_type_id, :upper_people_n, :fee).merge(store_id: params[:store_id])
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end 

  def search_calendar(date)
    y = date.year
    m = date.month
    s_date = Date.new(y,m,1)
    @calendar = Calendar.find_by(std_date: s_date, store_id: @store.id)
  end

end
