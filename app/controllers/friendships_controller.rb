class FriendshipsController < ApplicationController
  @is_unfriend = false
  def new
    @users = User.all_except(current_user).order(:name).page(params[:page])
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Request sent successfully"
      redirect_to new_friendship_path
    else
      flash[:error] = "Already Friends"
      redirect_to new_friendship_path
    end
  end

  def destroy
    current_user.friendships.where(friend_id: params[:id]).first&.destroy!
    if @is_unfriend
      redirect_to friendships_path
    else
      redirect_to requests_sent_friendships_path
    end
  end

  def unfriend
    @is_unfriend = true
    destroy()
  end

  def accept_request
    @friend = Friendship.existing_friends(params[:id], current_user.id)
  end
  
  def update
    @friend = Friendship.find(params[:id])
    if @friend.update(friend_params)
      flash[:success] = "Request Accepted"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to friendships_path
  end

  def pending_friends
    @friends_req_pending = current_user.pending_friends
  end

  def requests_sent
    @friends_request_sent = current_user.sent_requests
  end

  def index
    @friends = current_user.my_friends
  end

  private
  def friend_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
