class RenameUpdateLogToAlfabetaUpdate < ActiveRecord::Migration
  def change
    execute 'TRUNCATE TABLE update_logs;'
    execute 'TRUNCATE TABLE price_histories;'

    rename_table :update_logs, :alfabeta_updates

    remove_column :price_histories, :identifier
    remove_column :price_histories, :product_id

    add_reference :price_histories, :product, index: true, foreign_key: true
    add_reference :price_histories, :alfabeta_update, index: true, foreign_key: true
  end
end
