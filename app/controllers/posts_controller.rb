class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = MoviesService.new(current_user, post_params).execute
    respond_to do |format|
      if @post.errors.blank? && @post.save
        format.html { redirect_to root_url, notice: 'Your video was successfully shared. Thank you!' }
        format.json { render :show, status: :created, location: @post }
      else
        flash[:error] = @post.errors.full_messages.first
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:youtube_url)
  end
end
