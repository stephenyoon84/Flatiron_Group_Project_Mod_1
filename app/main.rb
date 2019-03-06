ActiveRecord::Base.logger = nil
require 'tty-table'
require_relative '../config/environment'

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
  end

  def self.invalid_option
    print "\n\n\s\sPlease select a valid option.\n"
  end

  def self.main_menu
    print "\n\n\sPlease choose the menu.\n\s\s1. Find a cocktail by name.\n\s\s2. Find possible cocktail with your own liqours.\n\s\s3. Find cocktails based on ther ABV.\n\s\s4. Exit.\n\s\sInput: "
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
    else
      self.invalid_option
      self.main_menu
    end
  end

  def self.find_cocktail_by_name_menu
    Screen.clear
    DisplayTable.recipes_table
    print "\n\nPlease input the cocktail  number to find your recipe.\n\sInput :"
    user_input = gets.chomp.to_i
    case user_input
    when 1..77
      Recipe.find(user_input).print_needed_ingredients
    else
      self.invalid_option
      self.find_cocktail_by_name_menu
    end
    self.main_menu
  end

  def self.find_by_ingredient_first
    print "Please select a first ingredient number you want to see available cocktails.\n\sInput: "
    user_input = gets.chomp.to_i
    case user_input
    when 1..52
      Ingredient.find(user_input).print_possible_cocktails
    else
      self.invalid_option
    end
    return user_input
  end

  def self.find_by_ingredient_second(user_input)
    print "Please select a second ingredient number you want to use with your first ingredient.\n\sInput: "
    user_input2 = gets.chomp.to_i
    loop do
      if user_input2 == user_input
        print "You already selected that ingredient. Please select different one.\n\sInput: "
        user_input2 = gets.chomp.to_i
      end
      case user_input2
      when 1..52
          Ingredient.find(user_input).possible_cocktails_two_ing(Ingredient.find(user_input2))
          break
      else
        self.invalid_option
      end
    end
  end

  def self.find_cocktail_by_ingredient_menu
    Screen.clear
    DisplayTable.ingredients_table
    user_input = self.find_by_ingredient_first
    print "Would you like to add another ingredient? (y/n)\n\sInput: "
    user_input3 = gets.chomp
    case user_input3
    when "y" # || "Y" || "yes" || "YES" || "Yes"
      self.find_by_ingredient_second(user_input)
    when "n" # || "N" || "no" || "NO" || "No"
      print "Enjoy your cocktail!!"
    else
      self.invalid_option
    end
    self.main_menu
  end

  def self.find_cocktail_by_abv
    Screen.clear
    print "Choose a number for your cocktails based on their ABV.\n\s1. Light Cocktails\n\s2. Medium Cocktails\n\s3. Strong Cocktails\n\s4. Back to Main Menu\n\nInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      Recipe.where("abv < 15").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    when "2"
      Recipe.where("abv >= 15 AND abv < 30").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    when "3"
      Recipe.where("abv >= 30 AND abv < 41").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
    when "4"
      return self.main_menu
    else
      self.invalid_option
    end
    self.main_menu
  end
end
