require_relative './spec_helper'

describe Recipe do
  before :all do
    @liqour1 = Ingredient.find_or_create_by(name: "A", abv: 40)
    @liqour2 = Ingredient.find_or_create_by(name: "B", abv: 20)
    @recipe1 = Recipe.find_or_create_by(name: "A2B2")
    @recipe2 = Recipe.find_or_create_by(name: "A1B4")
  end

  after :all do
    Ingredient.find(@liqour1.id).delete
    Ingredient.find(@liqour2.id).delete
    Recipe.find(@recipe1.id).delete
    Recipe.find(@recipe2.id).delete
  end

  it "recipe has many ingredients through recipe_ingredients" do
    expect(@recipe1.ingredients).to eq([@liqour1, @liqour2])
  end
end
