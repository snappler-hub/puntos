class Migration

  def self.acciofar
    ManesPresent::Acciofar.find_each do |each|
      id = each.id
      descripcion = Nokogiri::HTML.parse(each.descripcion).text.strip
      PharmacologicScope.create(
          id: id,
          description: descripcion
      ); nil
    end
  end

end
