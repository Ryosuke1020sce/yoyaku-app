class CalendarsController < ApplicationController
  before_action :set_various, only: [:show, :guests_show, :guests_search]

  def create
    if !same_date_exist
      @calendar = Calendar.new(calendar_params)
      if @calendar.save
        redirect_to store_reservations_path(params[:store_id])
      end
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def guests_show
    @calendar = Calendar.find(params[:calendar_id])
  end

  def guests_search
    @calendar = Calendar.find(params[:calendar_id])
    @rsv_number = RsvNumber.new
  end

  def guests_confirm
    @rsv_number = RsvNumber.find_by(unique_number: params[:rsv_number][:unique_number])
    @guest = Guest.find(@rsv_number.guest_id)
    @reservation = Reservation.find(@guest.reservation_id)
    @store = Store.find(@reservation.store_id)
    redirect_to store_reservation_guest_path(@store.id, @reservation.id, @guest.id)
  end

  private

  def calendar_params
    params.require(:calendar).permit(:std_date).merge(store_id: params[:store_id])
  end

  def same_date_exist
    @exists = Calendar.where(store_id: params[:store_id], std_date: params[:calendar][:std_date])
    if @exists.count == 0
      return false
    else
      return true
    end
  end

  def set_various
    @store = Store.find(params[:store_id])
    @reservations = Reservation.where(store_id: params[:store_id])
    @calendars = Calendar.where(store_id: params[:store_id])
  end

end
