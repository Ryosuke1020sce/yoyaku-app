class CalendarsController < ApplicationController

  def create
    if !same_date_exist
      @calendar = Calendar.new(calendar_params)
      if @calendar.save
        redirect_to store_reservations_path(params[:store_id])
      end
    end
  end

  def show
    @store = Store.find(params[:store_id])
    @reservations = Reservation.where(store_id: params[:store_id])
    @calendar = Calendar.find(params[:id])
    @calendars = Calendar.where(store_id: params[:store_id])
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

end
