# Las columnas agregadas en esta migración se corresponden con los siguiente
# campos (se respeta el orden):

# Presentacion
# Precio sugerido
# Fecha vigencia
# Marca de producto controlado
# Importado
# Tipo de venta
# Número de registro
# Baja
# Unidades
# Tamaño
# SIFAR
# Potencia
# Troquel
# Tamaño relativo de la presentación
# Acción farmacológica
# Droga
# Forma farmacológica
# Unidad de Potencia
# Tipo de unidad
# Vía de administración
# Laboratorio

class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :presentation_form, :string
    add_column :products, :price, :float
    add_column :products, :expiration_date, :date
    add_column :products, :controlled_product_mark, :integer # Enumerativo
    add_column :products, :imported, :boolean
    add_column :products, :sell_type, :integer # Enumerativo
    add_column :products, :registration_numer, :integer
    add_column :products, :deleted, :boolean, default: 0
    add_column :products, :units, :integer, default: 1
    add_column :products, :size, :integer # Enumerativo
    add_column :products, :sifar, :boolean
    add_column :products, :potency, :string
    add_column :products, :troquel_number, :string
    add_column :products, :relative_presentation_size, :integer
    add_index :products, :relative_presentation_size
    add_reference :products, :administration_route, index: true, foreign_key: true
    add_reference :products, :drug, index: true, foreign_key: true
    add_reference :products, :pharmacologic_form, index: true, foreign_key: true
    add_reference :products, :potency_unit, index: true, foreign_key: true
    add_reference :products, :unit_type, index: true, foreign_key: true
    add_reference :products, :pharmacologic_scope, index: true, foreign_key: true
    add_reference :products, :laboratory, index: true, foreign_key: true
  end
end