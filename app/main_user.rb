ActiveRecord::Base.logger = nil
require 'tty-table'
require_relative '../config/environment'

class CocktailApp_User < CocktailApp
  def self.main_menu(user_name_input)
    user_name = user_name_input
    Screen.clear
    Artscii.welcome
    print "\n\n\sPlease choose the menu.\n\s\s1. Find a cocktail by name.\n\s\s2. Find possible cocktail with your own liqours.\n\s\s3. Find cocktails based on ther ABV.\n\s\s4. Your list.\n\s\s5. Profile\n\s\s6. Exit.\n\s\sInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      self.find_cocktail_by_name_menu(user_name)
    when "2"
      self.find_cocktail_by_ingredient_menu(user_name)
    when "3"
      self.find_cocktail_by_abv(user_name)
    when "4"
      put "Your list."
      Screen.next
      self.main_menu(user_name)
    when "5"
      self.user_profile(user_name)
    when "6"
      Screen.clear
      Artscii.goodbye
    else
      CocktailApp.invalid_option
      print "\s\sPress enterkey to continue."
      Screen.next
      self.main_menu(user_name)
    end
  end

  def self.user_profile(user_name)
    Screen.clear
    Artscii.welcome
    print "\n\n\sPlease select option.\n\s\s1. Change Your Name.\n\s\s2. Change Your Password.\n\s\s3. Sign Out.\n\s\s4. Back to Main Menu.\n\s\sInput: "
    user_input = gets.chomp
    case user_input
    when "1"
      AccountHelper.change_name(user_name)
      Screen.next
      self.user_profile(user_name)
    when "2"
      AccountHelper.change_password(user_name)
      self.user_profile(user_name)
    when "3"
      AccountHelper.signout(user_name)
    when "4"
      Screen.clear
      self.main_menu(user_name)
    else
      CocktailApp.invalid_option
      print "\s\sPress enterkey to continue."
      Screen.next
      self.user_profile(user_name)
    end
  end
end
