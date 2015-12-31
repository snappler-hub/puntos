# == Schema Information
#
# Table name: pharmacologic_forms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PharmacologicForm < ActiveRecord::Base
end
