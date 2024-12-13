class CalendarsController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  private

  def calendar_params
    params.require(:calendar).permit(:std_date).merge(store_id: params[:store_id])
  end

end
