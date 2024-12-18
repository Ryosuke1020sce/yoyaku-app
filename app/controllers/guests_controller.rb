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
      store_id = @guest.reservation.store_id
      rsv_id = @guest.reservation.id
      @rsv_number = RsvNumber.create(unique_number: g_unique_number, guest_id: @guest.id)
      redirect_to "/stores/#{store_id}/reservations/#{rsv_id}/complete/#{@guest.id}"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def complete
    @guest = Guest.find(params[:id])
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :mail, :people_n, :tel).merge(reservation_id: params[:reservation_id])
  end

  def g_unique_number
    
    big_letters = ('A'..'Z').to_a
    small_letters = ('a'..'z').to_a
    letters = big_letters + small_letters
    v = big_letters.sample

    4.times do
      v += letters.sample
    end
    5.times do
      v += rand(0..9).to_s
    end

    return v
  end

end
