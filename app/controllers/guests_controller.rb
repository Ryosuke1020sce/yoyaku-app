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
    if @guest.mail != nil
      RsvMailer.complete_email(@guest).deliver_now
    end
  end
  
  def dammy_rsv
    @store = Store.find(params[:store_id])
    @rsv = Reservation.find(params[:reservation_id])
    rand_n = rand(1..4)
    @guest = Guest.create(reservation_id: @rsv.id, name: dammy_name, people_n: rand_n)
    @rsv_number = RsvNumber.create(unique_number: g_unique_number, guest_id: @guest.id)
    redirect_to store_reservation_path(@store.id, @rsv.id)
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

  def dammy_name

    name_list = []
    
    name_list1 = [
      "アベヒロシ","ヨシタカユリコ","マエダゴウドン","ヨシザワリョウ","オオタニショウヘイ",
      "カナダサトシ","マチダケイタ","ヒガマナミ","ワタナベケイスケ","ナカリイサ",
      "キムラタクヤ","オザワマサヨシ","ナガサワマサミ","オオサワタカオ","ハシモトカンナ",
      "サカモトマアヤ","ヤマデラコウイチ","ハナエナツキ","ヤマザキワカナ","オオタニイクコ",
    ]

    name_list2 = [
      "スズキノボル","ナカムラタケシ","タナカワタル","サトウケンジ","ヤマモトカズナリ",
      "アライラン","ヤマザキカナミ","カワムラヨシミ","フクナガナオミ","ゴトウルナ",
      "ウエノヨウヘイ","ナカムラオサム","オカベダイスケ","ウチダユウジ","マツモトカズマ",
      "ナカジマミオ","ゴトウマリコ","フクダユイ","ササキサチ","オカモトアキコ"
    ]

    name_list3 = [
      "カトウトモユキ","ウエハラマサキ","アベユキオ","カワグチタク","ナカノダイキ",
      "イトウトモコ","ウエノノリコ","イイダエミコ","ネモトユカ","ヨシノミユキ",
      "アラカワススム","シミズマサミ","イシダマモル","オオヒラユウイチ","ミウラアキラ",
      "ハタケヤマトモミ","ナガシマメグミ","フカヤアイ","クロダハルミ","ヨコイユウ"
    ]

    name_list4 = [
      "サトウヨシフミ","フクナガシュウイチ","コバヤシリョウ","ヤマモトヨシオ","タグチカズヨシ",
      "ミズグチナオコ","アンドウマナミ","ハシモトユカリ","アサノヒデミ","ヤマギシユミ",
      "セキツヨシ","ハラダダイスケ","キノシタオキヒロ","オノヨシヒコ","コマツタカノリ",
      "ナカノリカ","タカギメグミ","スギヤマアイコ","ナガオミナコ","オオツカマリコ"
    ]

    name_list += name_list1
    name_list += name_list2
    name_list += name_list3
    name_list += name_list4
    
    return name_list[rand(0..79)]

  end

end
