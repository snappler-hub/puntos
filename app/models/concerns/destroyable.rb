require 'active_support/concern'
module Destroyable
  extend ActiveSupport::Concern

  included do
    def destroyable?
      false
    end

    def destroy
      super if destroyable?
    end
  end

end