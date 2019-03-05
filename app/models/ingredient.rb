class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

<<<<<<< HEAD
  def print_possible_cocktails
    self.recipes.each { |drink| puts "#{drink.name}" }
=======
  def possible_cocktail_recipes
    self.recipe_ingredients.map do |drink|
      Recipe.find(drink.recipe_id)
    end
>>>>>>> 295c363ea4b8383c45069de0f72b3718c6c48401
  end

  def possible_cocktails_two_ing(ing2)
    self.recipes & ing2.recipes
  end
<<<<<<< HEAD
  
=======
>>>>>>> 295c363ea4b8383c45069de0f72b3718c6c48401
end
