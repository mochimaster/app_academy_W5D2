class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    flash[:sub_id] = params[:sub_id]
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = flash[:sub_id]
    flash[:sub_id] = nil
    @post.sub_ids = params[:post][:sub_ids]
    return
    if @post.save!
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.author.id == current_user.id
      render :edit
    else
      redirect_to sub_url(@post.sub_id)
    end

  end

  def update
    @post = Post.find(params[:id])
    return unless @post.author.id == current_user.id
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

end
