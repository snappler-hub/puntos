class AlfabetaUpdateFilter
  include ActiveModel::Model
  attr_accessor :start_date, :finish_date

  def call

    alfabeta_updates = AlfabetaUpdate.all.order(created_at: :desc)
    alfabeta_updates = alfabeta_updates.where(created_at: @start_date..@finish_date) if @start_date.present?

    alfabeta_updates
  end

end