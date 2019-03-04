class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredient

  def ingredients
    RecipeIngredient.where(recipe_id: self)
  end

  def cocktail_recipe
    cocktail_ingredients = self.ingredients
    cocktail_ingredients.each do |x|
      puts "#{Ingredient.find(x.ingredient_id).name}: #{x.amount} cl"
    end
  end
end
