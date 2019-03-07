require_relative './spec_helper'

describe Ingredient do

  before :all do
    @ingredient1 = Ingredient.find_or_create_by(name: "a", abv: 20)
    @ingredient2 = Ingredient.find_or_create_by(name: "b", abv: 30)
    @recipe1 = Recipe.find_or_create_by(name: "A")
    @recipe2 = Recipe.find_or_create_by(name: "B")
    @recing1 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A").id, ingredient_id: Ingredient.find_by(name: "a").id, amount: 2.0)
    @recing2 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "B").id, ingredient_id: Ingredient.find_by(name: "b").id, amount: 3.0)
    @recing3 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A").id, ingredient_id: Ingredient.find_by(name: "b").id, amount: 1.0)
    @recing4 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "B").id, ingredient_id: Ingredient.find_by(name: "a").id, amount: 4.0)
  end

  after :all do
    Ingredient.find(@ingredient1.id).delete
    Ingredient.find(@ingredient2.id).delete
    Recipe.find(@recipe1.id).delete
    Recipe.find(@recipe2.id).delete
    RecipeIngredient.find(@recing1.id).delete
    RecipeIngredient.find(@recing2.id).delete
    RecipeIngredient.find(@recing3.id).delete
    RecipeIngredient.find(@recing4.id).delete
  end

  it "has a name" do
    expect(@ingredient1.name).to eq("a")
  end

  it "has an abv" do
    expect(@ingredient2.abv).to eq(30)
  end

  it "has many recipes through recipe ingredients" do
    expect((@ingredient1.recipes).include?(@recipe1)).to be(true)
  end

  it "#print_possible_cocktails correctly prints out the cocktails that can be made with that ingredient" do
    expect(@ingredient2.print_possible_cocktails).to match_array([@recipe2, @recipe1])
  end

  it "#possible_cocktails_two_ing(ing2) raises an Argument error if input is not an Ingredient object" do
    expect{ @ingredient1.possible_cocktails_two_ing(5) }.to raise_error ArgumentError
  end
end
