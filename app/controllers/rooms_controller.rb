class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = current_user.rooms.public_rooms
    @users = User.all_except(current_user)
  end

  def show
    @single_room = Room.find(params[:id])
    @room = Room.new
    @rooms = current_user.rooms.public_rooms
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @users = User.all_except(current_user)
    render 'index'
  end

  def create
    @room = Room.new(room_params)
    @room.participants << Participant.new(user: current_user)
    if @room.save
      redirect_to @room
    end
  end


  def manage_participants
    @room = Room.find(params[:id])
    @single_room = @room
    @participants = @room.participants
    @users = User.all_except(@room.users)
  end

  def update_participants
    @room = Room.find(params[:id])
    user_ids = params[:room][:user_ids].reject(&:empty?)
    @room.users << User.where(id: user_ids)
    redirect_to @room
  end 

  def add_participant
    @room = Room.find(params[:id])
    user = User.find(params[:room][:user_id])
    @room.participants << Participant.new(user: user)
    redirect_to @room
  end

  def remove_participant
    @room = Room.find(params[:id])
    user = User.find(params[:room][:user_id])
    @room.participants.where(user_id: user.id).destroy_all
    redirect_to @room
  end


  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end

end
