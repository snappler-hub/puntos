# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      not null
#  crypted_password                :string(255)
#  salt                            :string(255)
#  role                            :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  created_by_id                   :integer
#  supplier_id                     :integer
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  number                          :integer
#  document_type                   :string(255)
#  document_number                 :string(255)
#  phone                           :string(255)
#  address                         :string(255)
#  username                        :string(255)
#  image_uid                       :string(255)
#  image_name                      :string(255)
#  card_number                     :string(255)
#  terms_accepted                  :boolean          default(FALSE)
#  card_printed                    :boolean          default(FALSE)
#  card_delivered                  :boolean          default(FALSE)
#  supplier_request_id             :integer
#  cache_points                    :integer          default(0)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
