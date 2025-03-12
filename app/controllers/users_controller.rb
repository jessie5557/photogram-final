class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "users/index" })
  end

  def show
    @the_username = params.fetch("username")
    @matching_user = User.where({ :username => @the_username }).at(0)

    @list_of_own_photos = Photo.where({ :owner_id => @matching_user.id })
  end

  def liked
    @the_username = params.fetch("username")
    @matching_user = User.where({ :username => @the_username }).at(0)

    @list_of_likes = Like.where ({ :fan_id => @matching_user.id })
  end

  def feed
    @the_username = params.fetch("username")
    @matching_user = User.where({ :username => @the_username }).at(0)
    
    @list_of_follows = FollowRequest.where({ :sender_id => @matching_user.id, :status => "approved" })
    @list_of_followed_creators = User.where({ :id => @list_of_follows.recipient_id })
    @photos_of_followed_creators = @list_of_followed_creators.photos
  end

end
