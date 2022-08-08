require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'model methods' do
    it "plants below a 100 days harvest" do
        turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    
        
        plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        plot_3 = turing_garden.plots.create!(number: 2, size: "Small", direction: "South")
        plot_4 = turing_garden.plots.create!(number: 738, size: "Medium", direction: "West")

        plant_1 = Plant.create!(name: 'Carrots', description: 'bunnies love em', days_to_harvest: 65)
        plant_2 = Plant.create!(name: 'Spicy Peppers', description: 'hots pepper', days_to_harvest: 85)
        plant_3 = Plant.create!(name: 'Coffee Beans', description: 'Mmmm covfefe', days_to_harvest: 100)
        plant_4 = Plant.create!(name: 'Blueberries', description: 'turn your mouth blue', days_to_harvest: 40)
        plant_5 = Plant.create!(name: 'Pumpkins', description: 'perfect for jack-o-lanterns', days_to_harvest: 120)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_3.id)
        PlotPlant.create!(plot_id: plot_4.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_4.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_4.id, plant_id: plant_3.id)
        PlotPlant.create!(plot_id: plot_4.id, plant_id: plant_4.id)

        plots_plants_array = turing_garden.plants_below_100_days.map do |plant|
          plant.plant_name
        end
        expect(plots_plants_array).to include(plant_1.name)
        expect(plots_plants_array).to include(plant_2.name)
        expect(plots_plants_array).to_not include(plant_3.name)
    end
  end
end
