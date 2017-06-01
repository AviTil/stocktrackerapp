class FriendshipsController < ApplicationController

  def destroy
    @friendship=Friendship.find(params[:id])
    @friendship.destroy
    flash[:success]="You are no longer following this person"
    redirect_to user_path(current_user)
  end
  
  def create
    @friendship=Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship.save
    flash[:success]="Now following this person"
    redirect_to user_path(current_user)
  end

end