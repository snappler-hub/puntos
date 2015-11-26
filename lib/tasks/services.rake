namespace :services do

  # Marca los períodos finalizados sin cumplir el objetivo como vencidos
  task  check_periods: :environment do    
    expired_periods = PfpcPeriod.where("end_date < ? AND status = ?", Date.today, PfpcPeriod.statuses[:in_progress])
    expired_periods += PointsPeriod.where("end_date < ? AND status = ?", Date.today, PointsPeriod.statuses[:in_progress])
    
    expired = renewed = 0
    expired_periods.each do |period|
      if period.can_renew?
        period.service.create_period
        renewed += 1
      else
        period.mark_as_expired
        expired += 1 
      end
    end
    
    puts "#{renewed} servicios renovados"
    puts "#{expired} servicios vencidos"
  end
  
end