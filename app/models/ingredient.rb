class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  def possible_cocktail_recipes
    self.recipe_ingredients.map do |drink|
      Recipe.find(drink.recipe_id)
    end
  end

  def possible_cocktails_two_ing(ing2)
    self.possible_cocktail_recipes & ing2.possible_cocktail_recipes
  end
end
