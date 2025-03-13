class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  
  def index
    public_users = User.where({ :private => false })
    public_user_ids = []  # Initialize an empty array
    public_users.each do |user|  # Manually extract user IDs
      public_user_ids.push(user.id)
    end
    public_photos = Photo.where({ :owner_id => public_user_ids})  # Query photos using filtered IDs
    @list_of_public_photos = public_photos.order(created_at: :desc)  # Order by creation time

    render({ :template => "photos/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)
    @list_of_comments = Comment.where({ :photo_id => @the_photo.id})

    render({ :template => "photos/show" })
  end

  def create
    the_photo = Photo.new
    the_photo.image = params.fetch("query_image")
    the_photo.caption = params.fetch("query_caption")
    the_photo.owner_id = params.fetch("query_owner_id")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.likes_count = params.fetch("query_likes_count")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.image = params.fetch("query_image")
    the_photo.caption = params.fetch("query_caption")
    the_photo.owner_id = params.fetch("query_owner_id")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.likes_count = params.fetch("query_likes_count")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
