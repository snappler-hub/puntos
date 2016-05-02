module ServiceHelper

  def available_services_for(user)
    service_types = Service::TYPES
    service_types = service_types - ['seller'] unless user.is?([:god, :seller])
    service_types
  end

end
