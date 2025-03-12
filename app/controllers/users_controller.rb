class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "users/index" })
  end

  def show
    @the_username = params.fetch("username")
    @matching_user = User.where({ :username => @the_username }).at(0)
  end

  def liked
    @the_username = params.fetch("username")
    @matching_user = User.where({ :username => @the_username }).at(0)

    @list_of_liked_photos = Like.where ({ :fan_id => @matching_user.id })
  end

end
