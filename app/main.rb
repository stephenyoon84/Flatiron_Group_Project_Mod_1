ActiveRecord::Base.logger = nil
require 'tty-table'

module Screen
   def self.clear
       print "\ec\e[3J"
   end

   def self.next
     user_input = nil
     while user_input == nil
       user_input = gets.chomp
     end
   end
end

class CocktailApp
  def self.welcome
    Screen.clear
    Artscii.welcome
    print "\s\sWelcome to Get Your Cocktail! You can search what kind of ingredients you need to make cocktail you want or you can get cocktail recipes with your own ingredients.\n"
    # Screen.next
  end

  def self.invalid_option
    print "\n\n\s\sPlease select a valid option.\n"
  end

  def self.main_menu
    print "\n\n\n\n\sPlease choose the menu.\n\s\s1. Find a cocktail by name.\n\s\s2. Find possible cocktail with your own liqours.\n\s\s3. Find cocktails based on ther ABV.\n\s\s4. Exit.\n\s\sInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      self.find_cocktail_by_name_menu
    when "2"
      self.find_cocktail_by_ingredient_menu
    when "3"
      self.find_cocktail_by_abv
    when "4"
      Screen.clear
      Artscii.goodbye
      Screen.next
    else
      self.invalid_option
      self.main_menu
    end
  end

  def self.find_cocktail_by_name_menu
    Screen.clear
    DisplayTable.recipes_table
    # user_input = gets.chomp.to_i
    # a = Recipe.find_by(user_input)
    # a.print_needed_ingredients
    self.main_menu
  end

  def self.find_cocktail_by_ingredient_menu
    Screen.clear
    DisplayTable.ingredients_table
    self.main_menu
  end

  def self.find_cocktail_by_abv
    Screen.clear
    print "Choose a number for your cocktails based on their ABV.\n\s1. Light Cocktails\n\s2. Medium Cocktails\n\s3. Strong Cocktails\n\nInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      Recipe.where("abv < 15").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    when "2"
      Recipe.where("abv >= 15 AND abv < 30").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    when "3"
      Recipe.where("abv >= 30 AND abv < 41").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    else
      self.invalid_option
    end
    self.main_menu
  end
end
