class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:show, :edit, :update, :show, :destroy]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to store_reservations_path(@store.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # 「本当に削除しますか？」の確認を追加したい！JavaScriptで
    @reservation.destroy
    redirect_to store_reservations_path(@store.id)
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
end
