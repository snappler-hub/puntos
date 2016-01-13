# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      not null
#  username                        :string(255)
#  role                            :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  supplier_id                     :integer
#  number                          :integer
#  document_type                   :string(255)
#  document_number                 :string(255)
#  phone                           :string(255)
#  address                         :string(255)
#  card_number                     :string(255)
#  string                          :string(255)
#  terms_accepted                  :boolean          default(FALSE)
#  card_printed                    :boolean          default(FALSE)
#  card_delivered                  :boolean          default(FALSE)
#  cache_points                    :integer          default(0)
#  image_uid                       :string(255)
#  image_name                      :string(255)
#  created_by_id                   :integer
#  crypted_password                :string(255)
#  salt                            :string(255)
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  created_at                      :datetime
#  updated_at                      :datetime
#  supplier_request_id             :integer
#

require 'test_helper'

class UserPointsTest < ActiveSupport::TestCase
  
  setup do
    @user = users(:final_user2)
    @service = PointsService.create!(user: @user, name: 'Puntos', amount: 10) # Esto crea un período con available en 0
    
    # Creo 2 períodos más. El primero se crea con el servicio
    @service.create_period
    @service.create_period
  end
  
  test 'with not enough poings' do 
    @user.update_attribute(:cache_points, 50)
    assert_not(@user.decrease_points(100))
  end
  
  test "decrease user and services points" do
    # La prueba realiza lo siguiente:
    # El usuario cuenta con 70 puntos con 3 períodos con 0, 20 y 50 en available
    # Intentar canjear 100 puntos, debería fallar
    # Canjear 60: Resultado => P1 -> 0, P2 -> 0, P3 -> 10    
    @service.periods.second.update_attribute(:available, 20)
    @service.periods.third.update_attribute(:available, 50)
    @user.update_attribute(:cache_points, 70)
    
    @user.decrease_points(60)
    assert_equal(10, @user.reload.cache_points)
    assert_equal(0, @service.periods.first.available)
    assert_equal(0, @service.periods.second.available)
    assert_equal(10, @service.periods.third.available)
    
    @user.update_attribute(:cache_points, 50)
    @user.decrease_points(50)
    assert_equal(0, @user.reload.cache_points)

  end
  
  test "decrease points with more cache points than period points sum" do
    # La prueba realiza lo siguiente:
    # El usuario cuenta con 30 puntos con 3 períodos con 0, 0 y 10 en available
    # Canjear 20: Resultado => P1 -> 0, P2 -> 0, P3 -> 0. Cache points 10
    @service.periods.first.update_attribute(:available, 0)
    @service.periods.second.update_attribute(:available, 0)
    @service.periods.third.update_attribute(:available, 0)
    
    @user.update_attribute(:cache_points, 30)
    @user.decrease_points(20)
    assert_equal(10, @user.reload.cache_points)
  end
    
end
