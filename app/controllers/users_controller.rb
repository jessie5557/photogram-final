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
    # Extract recipient IDs using .push
    recipient_ids = []
    @list_of_follows.each do |follow|
      recipient_ids.push(follow.recipient_id)  # Store recipient IDs
    end

    # Fetch photos from all followed creators
    @list_of_photos_of_followed_creators = Photo.where({ :created_by => recipient_ids })
  end
end
