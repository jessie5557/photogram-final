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
  end

end
