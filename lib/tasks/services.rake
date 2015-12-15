namespace :services do

  # Marca los períodos finalizados sin cumplir el objetivo como vencidos
  task check_periods: :environment do
    expired_periods = PfpcPeriod.where('end_date < ? AND status = ?', Date.today, PfpcPeriod.statuses[:in_progress])
    expired_periods += PointsPeriod.where('end_date < ? AND status = ?', Date.today, PointsPeriod.statuses[:in_progress])

    expired = renewed = 0
    expired_periods.each do |period|
      if period.can_renew?
        period.renew
        renewed += 1
      else
        period.mark_as(:expired)
        period.service.mark_as(:expired)
        expired += 1
      end
    end

    puts "#{renewed} servicios renovados"
    puts "#{expired} servicios vencidos"
  end

  # Vencimiento de los puntos de un servicio de puntos
  task points_expiration: :environment do
    expired_periods = PointsPeriod.joins(:service).where('points_periods.end_date < NOW() - INTERVAL services.days_to_points_expiration DAY AND points_periods.available > 0')
    expired_periods.map { |period| period.expire_points }
    
    puts "#{expired_periods.size} períodos vencidos"
  end

end