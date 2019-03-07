require_relative './spec_helper'

describe Recipe do
  before :all do
    @liqour1 = Ingredient.find_or_create_by(name: "A", abv: 40)
    @liqour2 = Ingredient.find_or_create_by(name: "B", abv: 20)
    @recipe1 = Recipe.find_or_create_by(name: "A2B2")
    @recipe2 = Recipe.find_or_create_by(name: "A1B4")
    @r_l1 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A2B2").id, ingredient_id: Ingredient.find_by(name: "A").id, amount: 2.0)
    @r_l2 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A2B2").id, ingredient_id: Ingredient.find_by(name: "B").id, amount: 2.0)
    @r_l3 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A1B4").id, ingredient_id: Ingredient.find_by(name: "A").id, amount: 1.0)
    @r_l4 = RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: "A1B4").id, ingredient_id: Ingredient.find_by(name: "B").id, amount: 4.0)
    @r_s1 = RecipeSpecial.find_or_create_by(recipe_id: Recipe.find_by(name: "A2B2").id, special: "salt")
  end

  after :all do
    Ingredient.find(@liqour1.id).delete
    Ingredient.find(@liqour2.id).delete
    Recipe.find(@recipe1.id).delete
    Recipe.find(@recipe2.id).delete
    RecipeIngredient.find(@r_l1.id).delete
    RecipeIngredient.find(@r_l2.id).delete
    RecipeIngredient.find(@r_l3.id).delete
    RecipeIngredient.find(@r_l4.id).delete
    RecipeSpecial.find(@r_s1.id).delete
  end

  it "1. recipe has many ingredients through recipe_ingredients" do
    expect(@recipe1.ingredients).to include(@liqour1, @liqour2)
  end

  it "2. recipe has many special ingredients through recipe_specials" do
    expect(@recipe1.recipe_specials).to include(@r_s1)
  end

  it "3. Recipe#get_ingredients_total_alcohol can calculate recipe's total alcohol of cocktail" do
    expect(@recipe1.get_ingredients_total_alcohol).to eq(120.0)
  end

  it "4. Recipe#get_ingredients_total_amount can calculate recipe's total amount of cocktail" do
    expect(@recipe1.get_ingredients_total_amount).to eq(4.0)
  end

  it "5. Recipe#calculate_abv can calculate recipe's ABV" do
    expect(@recipe1.calculate_abv).to eq(30)
  end
end
