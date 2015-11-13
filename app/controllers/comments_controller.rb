class CommentsController < ApplicationController
  layout false
  
  before_filter :load_commentable, only: [:index, :create]
  before_filter :commentable_permission!, only: [:index, :create]
  before_filter :get_comment, only: [:destroy, :update]
  before_filter :comment_permission!, except: [:index, :create]

  def index
    @comments = @commentable.comments.page(params[:page])
    respond_to do |format|
      format.html do
        @comment = Comment.new
      end
      format.js
    end    
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update_attributes(comment_params)
    respond_to do |format|
      format.json { respond_with_bip(@comment) }
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def load_commentable
    klass = [SupplierRequest].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
  
  def commentable_permission!
    authorize! current_user.can_view?(@commentable)
  end
  
  def comment_permission!
    authorize! @comment.user == current_user
  end
end
