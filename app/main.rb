ActiveRecord::Base.logger = nil
require 'tty-table'
require_relative '../config/environment'

class CocktailApp
  Color = Pastel.new
  def self.welcome
    Screen.clear
    Artscii.welcome
    print Color.bright_blue.bold("\n\s\s\s\s\s\s\s\s\sWelcome to Get Your Cocktail!  Let us help you get your drink on!\n")
  end

  def self.invalid_option
    print Color.red("\n\n\s\sInvalid option.\n")
  end

  def self.main_menu(user_name_input = nil)
    user_name = user_name_input
    Screen.clear
    Artscii.welcome
    print Color.white("\n\n\s\e[4mPlease select one of the following options:\e[0m") + Color.white("\n\s\s1. Find a cocktail by name.\n\s\s2. Find cocktails you can make with your current ingredients.\n\s\s3. Find cocktails based off alcohol content.\n\s\s4. Exit.\n\n\s\sInput: ")
    user_input = gets.chomp
    case user_input
    when "1"
      self.find_cocktail_by_name_menu(user_name)
    when "2"
      self.find_cocktail_by_ingredient_menu(user_name)
    when "3"
      self.find_cocktail_by_abv(user_name)
    when "4"
      Screen.clear
      Artscii.goodbye
    else
      self.invalid_option
      print "\s\sPress any key to continue."
      Screen.next
      self.main_menu(user_name)
    end
  end

  def self.find_cocktail_by_name_menu_text(user_name = nil)
    print Color.white("\n\n\sPlease input a cocktail's number to see its recipe.\n\sTo go back to the main menu, input quit.\n\n\s\sInput: ")
    user_input = gets.chomp
    case user_input
    when "1".."77"
      Recipe.find(user_input).print_needed_ingredients
      self.find_cocktail_by_name_menu_text(user_name)
    when "quit", "Quit", "QUIT", "q", "Q"
      self.main_menu(user_name)
    else
      self.invalid_option
      self.find_cocktail_by_name_menu_text(user_name)
    end
  end

  def self.find_cocktail_by_name_menu(user_name = nil)
    Screen.clear
    DisplayTable.recipes_table
    self.find_cocktail_by_name_menu_text(user_name)
  end

  def self.find_by_ingredient_first(user_name = nil)
    print Color.white("\n\n\sPlease select an ingredient's number to see the cocktails you can make with it.\n\sTo go back to the main menu, input quit.\n\n\s\sInput: ")
    user_input = gets.chomp
    case user_input
    when "1".."52"
      Ingredient.find(user_input).print_possible_cocktails
      self.ask_user_want_second(user_input, user_name)
    when "quit", "Quit", "QUIT", "q", "Q"
      self.main_menu(user_name)
    else
      self.invalid_option
      self.find_by_ingredient_first(user_name)
    end
  end

  def self.ask_user_want_second(user_input, user_name = nil)
    print Color.white("\n\n\sWould you like to add another ingredient? (y/n)\n\n\s\sInput: ")
    user_input3 = gets.chomp
    case user_input3
    when "y", "Y", "yes", "YES", "Yes"
      self.find_by_ingredient_second(user_input, user_name)
    when "n", "N", "no", "NO", "No"
      print Color.white("\n\sEnjoy your cocktail!!!\n\sPress any key to go back to the main menu.\n")
      Screen.next
      self.main_menu(user_name)
    else
      self.invalid_option
      self.ask_user_want_second(user_input, user_name)
    end
  end

  def self.find_by_ingredient_second(user_input, user_name = nil)
    print Color.white("\n\sPlease select a second ingredient you would like to use with your first ingredient.\n\sTo go back to the main menu, input quit.\n\n\s\sInput: ")
    user_input2 = gets.chomp
    case user_input2
    when user_input
      print Color.white("\n\sYou already selected that ingredient. Please choose a different one.\n")
      self.find_by_ingredient_second(user_input,user_name)
    when "1".."52"
      Ingredient.find(user_input).possible_cocktails_two_ing(Ingredient.find(user_input2))
      print Color.white("\n\sEnjoy your cocktail!!!\n\sPress any key to go back to main menu.\n")
      Screen.next
      Screen.clear
      self.main_menu(user_name)
    when "quit", "Quit", "QUIT", "q", "Q"
      self.main_menu(user_name)
    else
      self.invalid_option
      self.find_by_ingredient_second(user_input, user_name)
    end
  end

  def self.find_cocktail_by_ingredient_menu(user_name = nil)
    Screen.clear
    DisplayTable.ingredients_table
    self.find_by_ingredient_first(user_name)
  end

  def self.find_cocktail_by_abv_text(user_name = nil)
    print Color.white("\n\n\sChoose one of the following options for a list of drinks based off strength:\n\n\s1. Light Cocktails\n\s2. Medium Cocktails\n\s3. Strong Cocktails\n\s4. Main Menu\n\n\s\sInput: ")
    user_input = gets.chomp
    case user_input
    when "1"
      Recipe.where("abv < 15").each{|x| puts Color.white("* #{x.name} - #{x.abv}% ABV.")}
      self.find_cocktail_by_abv_text(user_name)
    when "2"
      Recipe.where("abv >= 15 AND abv < 30").each{|x| puts Color.white("* #{x.name} - #{x.abv}% ABV.")}
      self.find_cocktail_by_abv_text(user_name)
    when "3"
      Recipe.where("abv >= 30 AND abv < 41").each{|x| puts Color.white("* #{x.name} - #{x.abv}% ABV.")}
      self.find_cocktail_by_abv_text(user_name)
    when "4"
      self.main_menu(user_name)
    else
      self.invalid_option
      self.find_cocktail_by_abv_text(user_name)
    end
  end

  def self.find_cocktail_by_abv(user_name)
    Screen.clear
    self.find_cocktail_by_abv_text(user_name)
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
      self.main_menu
    when "4", "quit", "Quit", "q", "Q"
      Screen.clear
      Artscii.goodbye
    else
      self.invalid_option
      self.front_menu
    end
  end
end
