class Garden < ApplicationRecord
  has_many :plots

  def plants_below_100_days
    plots.joins(:plants).select('plants.name as plant_name').where("plants.days_to_harvest < ?", 100).distinct
  end

  # def sort_plants_by_number
  #   plots.joins(:plants).select
  # end
end
