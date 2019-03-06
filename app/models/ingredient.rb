class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

Colorfont = Pastel.new

  def print_possible_cocktails
    self.recipes.each { |drink| puts Colorfont.white("* #{drink.name}") }
  end

  def possible_cocktails_two_ing(ing2)
    combination = self.recipes & ing2.recipes
    if combination.empty?
      print Colorfont.white("\n\sSorry. There are no recipes with that combination of ingredients.")
    else
      combination.each{|d| puts Colorfont.white("* #{d.name}")}
    end
  end

end
