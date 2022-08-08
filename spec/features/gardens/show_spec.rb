require 'rails_helper'

RSpec.describe "Garden Show Page" do
    before :each do
        @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    
        
        @plot_1 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        @plot_2 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        @plot_3 = @turing_garden.plots.create!(number: 2, size: "Small", direction: "South")
        @plot_4 = @turing_garden.plots.create!(number: 738, size: "Medium", direction: "West")

        @plant_1 = Plant.create!(name: 'Carrots', description: 'bunnies love em', days_to_harvest: 65)
        @plant_2 = Plant.create!(name: 'Spicy Peppers', description: 'hots pepper', days_to_harvest: 85)
        @plant_3 = Plant.create!(name: 'Coffee Beans', description: 'Mmmm covfefe', days_to_harvest: 100)
        @plant_4 = Plant.create!(name: 'Blueberries', description: 'turn your mouth blue', days_to_harvest: 40)
        @plant_5 = Plant.create!(name: 'Pumpkins', description: 'perfect for jack-o-lanterns', days_to_harvest: 120)

        PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
        PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_1.id)
        PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
        PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_1.id)
        PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_2.id)
        PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_3.id)
        PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_1.id)
        PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_2.id)
        PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_3.id)
        PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_4.id)

        visit "/gardens/#{@turing_garden.id}"
    end

    it 'displays all the plant in the gardens plots that take less than 100 days to harvest' do
        expect(page).to have_content(@plant_1.name, count: 1)
        expect(page).to have_content(@plant_2.name, count: 1)
        expect(page).to_not have_content(@plant_3.name)
        expect(page).to have_content(@plant_4.name, count: 1)
        expect(page).to_not have_content(@plant_5.name, count: 1)
        end
    
    it "displays the plants by number of plants that appear in each plot" do

    end
end

# User Story 3, Garden's Plants
# As a visitor
# When I visit an garden's show page
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest

# # Extension,
# # As a visitor
# # When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)