class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredient

  def possible_cocktail
    RecipeIngredient.where(ingredient_id: self)
  end

  # def possible_cocktail_with(liqour1, liqour2)
  #   RecipeIngredient.where(ingredient_id: Ingredient.find_by(name: liqour1)).each do |x|
  #   end
  # end

  # def possible_cocktail_with(string)
  #   arr_from_string = string.split(", ")
  #   if arr_from_string.size == 3
  #     a = arr_from_string[0].possible_cocktail
  #     b = arr_from_string[1].possible_cocktail
  #     c = arr_from_string[2].possible_cocktail
  #     result = []
  #     a.each do |x|
  #       if b.include?(x) &&
  #         c << x
  #       end
  #     end
  #   elsif arr_from_string.size == 2
  #
  #   else
  #     puts "You can only put maximum 3 liqour."
  #
  # end

end
