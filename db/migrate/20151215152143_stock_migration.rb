# -*- coding: utf-8 -*-
class StockMigration < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :real_stock_in_int, default: 0
      t.integer :warehouse_stock_in_int, default: 0
      t.references :stockable, polymorphic: true, index: true
      t.references :store, polymorphic: true
      t.timestamps null: false
    end
    create_table :stock_entries do |t|
      t.string :codename
      t.references :owner, polymorphic: true, index: true
      t.references :stock, index: true
      t.integer :amount_in_int, default: 0
      t.date :entry_date
      t.text :observation
      t.boolean :special, default: false
      t.boolean :applied, default: false

      t.timestamps null: false
    end
  end
end
