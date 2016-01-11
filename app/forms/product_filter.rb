class ProductFilter
  include ActiveModel::Model
  attr_accessor :name, :laboratory_id, :laboratory_name, :drug_id, :drug_name

  def call
    products = Product.all
    products = products.where('name LIKE ?', "%#{@name}%") if @name.present?
    if @laboratory_id.present?
      products = products.where('laboratory_id = ?', @laboratory_id) 
      @laboratory_name = Laboratory.find(@laboratory_id).try(:name)
    end
    if @drug_id.present?
      products = products.where('drug_id = ?', @drug_id) 
      @drug_name = Drug.find(@drug_id).try(:name)
    end
    products
  end
end