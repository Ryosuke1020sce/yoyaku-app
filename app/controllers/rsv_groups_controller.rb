class RsvGroupsController < ApplicationController

  def new
    @reservation = Reservation.new
  end

  def create
    binding.pry
  end


end
