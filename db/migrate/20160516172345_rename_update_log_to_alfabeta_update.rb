class RenameUpdateLogToAlfabetaUpdate < ActiveRecord::Migration
  def change
    rename_table :update_logs, :alfabeta_updates
  end
end
