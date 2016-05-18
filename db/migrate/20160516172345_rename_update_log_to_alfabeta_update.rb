class RenameUpdateLogToAlfabetaUpdate < ActiveRecord::Migration
  def change
    execute 'TRUNCATE TABLE update_logs;'

    rename_table :update_logs, :alfabeta_updates
  end
end
