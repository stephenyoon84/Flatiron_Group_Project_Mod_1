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
    Screen.clear
    Artscii.welcome
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

  def self.find_cocktail_by_name_menu_text
    print "\n\nPlease input the cocktail  number to find your recipe.\nIf you want to go back to the main menu, please input quit.\n\sInput :"
    user_input = gets.chomp
    case user_input
    when "1".."77"
      Recipe.find(user_input).print_needed_ingredients
      self.find_cocktail_by_name_menu_text
    when "quit", "Quit", "QUIT", "q", "Q"
      # Screen.clear
      self.main_menu
    else
      self.invalid_option
      self.find_cocktail_by_name_menu_text
    end
  end

  def self.find_cocktail_by_name_menu
    Screen.clear
    DisplayTable.recipes_table
    self.find_cocktail_by_name_menu_text
  end

  def self.find_by_ingredient_first
    print "Please select a first ingredient number you want to see available cocktails.\nIf you want to go back to the main menu, please input quit.\n\sInput: "
    user_input = gets.chomp
    case user_input
    when "1".."52"
      Ingredient.find(user_input).print_possible_cocktails
      self.ask_user_want_second(user_input)
    when "quit", "Quit", "QUIT", "q", "Q"
      # Screen.clear
      self.main_menu
    else
      self.invalid_option
      self.find_by_ingredient_first
    end
  end

  def self.ask_user_want_second(user_input)
    print "Would you like to add another ingredient? (y/n)\n\sInput: "
    user_input3 = gets.chomp
    case user_input3
    when "y", "Y", "yes", "YES", "Yes"
      self.find_by_ingredient_second(user_input)
    when "n", "N", "no", "NO", "No"
      print "Enjoy your cocktail!!\nPress any key to back to Main menu."
      Screen.next
      # Screen.clear
      self.main_menu
    else
      self.invalid_option
      self.ask_user_want_second(user_input)
    end
  end

  def self.find_by_ingredient_second(user_input)
    print "Please select a second ingredient number you want to use with your first ingredient.\nIf you want to go back to the main menu, please input quit.\n\sInput: "
    user_input2 = gets.chomp
    case user_input2
    when user_input
      print "You already selected that ingredient. Please select different one.\n"
      self.find_by_ingredient_second(user_input)
    when "1".."52"
      Ingredient.find(user_input).possible_cocktails_two_ing(Ingredient.find(user_input2))
      print "Enjoy your cocktail!!\nPress any key to back to Main menu."
      Screen.next
      Screen.clear
      self.main_menu
    when "quit", "Quit", "QUIT", "q", "Q"
      # Screen.clear
      self.main_menu
    else
      self.invalid_option
      self.find_by_ingredient_second(user_input)
    end
  end

  def self.find_cocktail_by_ingredient_menu
    Screen.clear
    DisplayTable.ingredients_table
    self.find_by_ingredient_first
  end

  def self.find_cocktail_by_abv_text
    print "\n\nChoose a number for your cocktails based on their ABV.\n\s1. Light Cocktails\n\s2. Medium Cocktails\n\s3. Strong Cocktails\n\s4. Back to Main Menu\n\nInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      Recipe.where("abv < 15").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
      self.find_cocktail_by_abv_text
    when "2"
      Recipe.where("abv >= 15 AND abv < 30").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
      self.find_cocktail_by_abv_text
    when "3"
      Recipe.where("abv >= 30 AND abv < 41").each{|x| puts "#{x.id}. #{x.name} has #{x.abv}% ABV."}
      self.find_cocktail_by_abv_text
    when "4"
      # Screen.clear
      self.main_menu
    else
      self.invalid_option
      self.find_cocktail_by_abv_text
    end
  end

  def self.find_cocktail_by_abv
    Screen.clear
    self.find_cocktail_by_abv_text
  end

  def self.front_menu
    print "\nPlease Select Menu.\n\s1. Sign In.\n\s2. Log In.\n\s3. I am a Guest.\n\s4. Exit.\n\n\s\sInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      AccountHelper.signin
      print "\nThank you for join us. Please enter any key to log in.\n"
      Screen.next
      AccountHelper.login
    when "2"
      AccountHelper.login
    when "3"
      CocktailApp.main_menu
    when "4", "quit", "Quit", "q", "Q"
      Screen.clear
      Artscii.goodbye
    else
      self.invalid_option
      self.front_menu
    end
  end
end
