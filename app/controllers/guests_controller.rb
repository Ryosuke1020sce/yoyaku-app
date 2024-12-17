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
      redirect_to store_path(@guest.reservation.store_id) # これは仮
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :mail, :people_n, :tel).merge(reservation_id: params[:reservation_id])
  end

end
