module Rollback
  extend ActiveSupport::Concern

  included do
    after_rollback :log_errors
  end

  def log_errors
    MigrationLogger.error "------------------------- Excepcion en #{self.class.to_s} con ID: #{self.id}"
    MigrationLogger.error "  Mensaje de error: #{(self.errors.messages.blank? ? $! : self.errors.messages)}"
    MigrationLogger.error "  Attributes: #{self.attributes}"
  end

end