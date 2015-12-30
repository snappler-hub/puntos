class Migration

  def self.acciofar
    ManesPresent::PharmacologicalScope.find_each do |each|
      PharmacologicScope.create(
          id: each.id,
          description: each.description
      ); nil
    end
  end

  def self.monodroga
    ManesPresent::Drug.find_each do |each|
      Drug.create(
          id: each.id,
          description: each.description
      ); nil
    end
  end

end
