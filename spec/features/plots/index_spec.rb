require 'rails_helper'

RSpec.describe "Plots Index Page" do

    before :each do
        @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
        @library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
        @other_garden = Garden.create!(name: 'Main Street Garden', organic: false)
        
        @plot_1 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        @plot_2 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        @plot_3 = @library_garden.plots.create!(number: 2, size: "Small", direction: "South")
        @plot_4 = @other_garden.plots.create!(number: 738, size: "Medium", direction: "West")

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
        visit "/plots"

    end
    it "can visit the plots index page, and show a list of all plot numbers" do
        expect(page).to have_content("Plots")
        expect(page).to have_content(25)
        expect(page).to have_content(26)
        expect(page).to have_content(2)
        expect(page).to have_content(738)
    end

    it "can visit the plots index page and show a list of that plot's plants under each plot" do
        

        within("#plot-#{@plot_1.id}") do
            expect(page).to have_content(@plant_1.name)
            expect(page).to_not have_content(@plant_2.name)
        end

        within("#plot-#{@plot_2.id}") do
            expect(page).to have_content(@plant_1.name)
            expect(page).to have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_3.name)
        end

        within("#plot-#{@plot_3.id}") do
            expect(page).to have_content(@plant_1.name)
            expect(page).to have_content(@plant_2.name)
            expect(page).to have_content(@plant_3.name)
            expect(page).to_not have_content(@plant_4.name)
        end
    end

    it 'displays a link to remove plant from plot and returns back to index page' do
        within("#plot-#{@plot_3.id}") do
            within("#plant-#{@plant_3.id}") do
                click_link 'Remove'
            end
            expect(current_path).to eq("/plots")
            expect(page).to_not have_content(@plant_3.name)
        end
    end
end

# User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see names of all that plot's plants

# User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit a plot's index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot
# (Note: you should not destroy the plant record entirely)