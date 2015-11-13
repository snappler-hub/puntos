class Comment < ActiveRecord::Base
  
  # -- Scopes
  default_scope { order(created_at: :desc) }

  # -- Associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # -- Validations
  validates :text, presence: true
  validates :user, presence: true
  
  # -- Methods

  def is_owner?(aUser)
    aUser == self.user    
  end

end
