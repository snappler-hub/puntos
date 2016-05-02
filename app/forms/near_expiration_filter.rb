class NearExpirationFilter
  include ActiveModel::Model
  attr_accessor :supplier_id, :date

  def call(context = false)
    services = context ? context.services : Service.all
    services = services.where('type = ? OR type = ?', 'PointsService', 'PfpcService')
    services = services.in_progress
    services = services.joins(:user).where('users.supplier_id = ?', @supplier_id) if @supplier_id.present?

    if @date.present?
      services = services.joins('LEFT JOIN pfpc_periods ON pfpc_periods.id = services.last_period_id AND type = "PfpcService"')
      services = services.joins('LEFT JOIN points_periods ON points_periods.id = services.last_period_id AND type = "PointsService"')
      services = services.where('((type = "PfpcService" AND pfpc_periods.end_date <= ?) OR (type = "PointsService" AND points_periods.end_date <= ?))', @date, @date)
    end

    service_ids = services.select { |s| !s.can_renew? }.map(&:id)
    Service.where(id: service_ids)
  end
end
