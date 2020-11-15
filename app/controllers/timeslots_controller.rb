class TimeslotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timeslot, only: [:show, :edit, :update, :destroy]

  def index 
    @client = current_user.clients.find_by_id(params[:client_id])
    @barber = Barber.find_by_id(params[:barber_id])
    if @client
      @timeslots = @client.timeslots
    elsif @barber 
      @timeslots = current_user.timeslots.by_barber(@barber)
    else
      @timeslots = current_user.timeslots
    end
    filter_options
  end

  def show 

  end 

  def new 
    @client = current_user.clients.find_by_id(params[:client_id])
    @barber = Barber.find_by_id(params[:barber_id])
    if @client
      @timeslot = @client.timeslots.build
    elsif @barber 
      @timeslot = @barber.timeslots.build
    else
      @timeslot = Timeslot.new
    end
  end

  def create 
    @timeslot = Timeslot.new(timeslot_params)
    if @timeslot.save 
      redirect_to timeslot_path(@timeslot)
    else 
      render :new
    end
  end

  def edit 
    
  end 

  def update 
    if @timeslot.update(timeslot_params)
      redirect_to timeslot_path(@timeslot)
    else
      render :edit
    end
  end 

  def destroy 
    @timeslot.destroy 
    redirect_to timeslots_path
  end

  private 


  def timeslot_params
    params.require(:timeslot).permit(:address, :start_time, :end_time, :barber_id, :client_id)
  end
end

def set_timeslot 
  @timeslot = current_user.timeslots.find(params[:id])
end

def filter_options 
  if params[:filter_by_time] == "upcoming"
    @timeslots = @timeslots.upcoming
  elsif params[:filter_by_time] == "past"
    @timeslots = @timeslots.past
  end
  if params[:sort] == "most_recent"
    @timeslots = @timeslots.most_recent
  elsif params[:sort] == "longest_ago" 
    @timeslots = @timeslots.longest_ago
  end
end
