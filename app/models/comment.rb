# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  text             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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
