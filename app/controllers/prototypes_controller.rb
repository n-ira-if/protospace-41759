class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :delete]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to '/'
   else
    render :new
   end
  end

  def show 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end