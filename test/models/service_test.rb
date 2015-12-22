# == Schema Information
#
# Table name: services
#
#  id                        :integer          not null, primary key
#  name                      :string(255)      not null
#  type                      :string(255)      not null
#  user_id                   :integer
#  last_period_id            :integer
#  amount                    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  days                      :integer          default(30)
#  vademecum_id              :integer
#  status                    :integer          default(0)
#  days_to_points_expiration :integer
#

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  
  test "create a points period after creating points service" do
    service = services(:points)
    service.run_callbacks(:create)
    assert_not_nil service.last_period
    assert_equal service.amount, service.last_period.amount 
    assert_equal 0, service.last_period.accumulated
    assert_equal 'pending', service.status, service.last_period.status
    assert_equal service.last_period.start_date, Date.today
    assert_equal service.last_period.end_date, Date.today + service.days.days
  end
  
  test "create a pfpc period after creating pfpc service" do
    service = services(:pfpc)
    service.run_callbacks(:create)
    assert_not_nil service.last_period
    assert_equal 2, service.last_period.period_products.count
    assert_equal 'pending', service.status, service.last_period.status
    assert_equal service.last_period.start_date, Date.today
    assert_equal service.last_period.end_date, Date.today + service.days.days
  end
  
  test "points service renoval" do
    service = services(:points)
    service.run_callbacks(:create)
    period = service.last_period
    
    assert_not period.can_renew?
    
    period.accumulated = period.amount
    period.save
    assert period.can_renew?
    
    assert_difference('PointsPeriod.count', 1) do
      period.renew
    end
  end
  
  test "pfpc service renoval" do
    service = services(:pfpc)
    service.run_callbacks(:create)
    period = service.last_period
    
    assert_not period.can_renew?
    
    period.period_products.update_all('accumulated = amount')
    assert period.can_renew?
    
    prod = period.period_products.first
    prod.accumulated = prod.amount + 5
    prod.save
    
    assert_difference('PfpcPeriod.count', 1) do
      period.renew
    end
    new_period = PfpcPeriod.last
    assert_equal 5, new_period.period_products.first.accumulated # Arrastra el extra al siguiente período
  end
  
end
