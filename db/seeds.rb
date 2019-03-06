require_relative '../config/environment'
require 'json'
require 'sqlite3'

# class ImportJson
  ingredient_path = File.expand_path('../ingredients.json', __FILE__)
  # ingredient_file = File.read(path)
  ingredient_hash = JSON.parse(File.read(ingredient_path))

  ingredient_hash.each do |k, v|
    Ingredient.find_or_create_by(name: k, abv: v["abv"], taste: v["taste"])
  end

  recipe_path = File.expand_path('../recipes.json', __FILE__)
  recipe_array = JSON.parse(File.read(recipe_path))

  recipe_array.each do |x|
    a = Recipe.find_or_create_by(name: x["name"])
  end

  recipe_array.each do |x|
    x["ingredients"].each do |y|
      if Ingredient.find_by(name: y["ingredient"])
        RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: x["name"]).id,
        ingredient_id: Ingredient.find_by(name: y["ingredient"]).id,
        amount: y["amount"])
      end
    end
  end

  recipe_array.each do |x|
    a = Recipe.find_or_create_by(name: x["name"])
    a.update(abv: a.calculate_abv, preparation: x["preparation"])
  end

  recipe_array.each do |x|
    if x["ingredients"].find{|x| x.include?("special")}
      x["ingredients"].select{|y| y.include?("special")}.each do |z|
        if x["garnish"]
          RecipeSpecial.find_or_create_by(recipe_id: Recipe.find_by(name: x["name"]).id, special: z["special"], garnish: x["garnish"])
        else
          RecipeSpecial.find_or_create_by(recipe_id: Recipe.find_by(name: x["name"]).id, special: z["special"])
        end
      end
    elsif x["garnish"]
      RecipeSpecial.find_or_create_by(recipe_id: Recipe.find_by(name: x["name"]).id, garnish: x["garnish"])
    end
  end
