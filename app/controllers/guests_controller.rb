class GuestsController < ApplicationController
  
  def index
    @guest = Guest.new
    @store = Store.find(params[:store_id])
    @reservation = Reservation.find(params[:reservation_id])

    r = @reservation.rsv_date
    std_date = Date.new(r.year, r.month, 1)

    @calendar = Calendar.where(store_id: @store.id, std_date: std_date)[0]
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      # 「予約が完了しました」
      store_id = @guest.reservation.store_id
      rsv_id = @guest.reservation.id
      redirect_to "/stores/#{store_id}/reservations/#{rsv_id}/complete/#{@guest.id}"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def complete
    @guest = Guest.find(params[:id])
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :mail, :people_n, :tel).merge(reservation_id: params[:reservation_id])
  end

end
