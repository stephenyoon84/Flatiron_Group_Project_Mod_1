ActiveRecord::Base.logger = nil

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
    print "Welcome to Get Your Cocktail! You can search what kind of ingredients you need to make cocktail you want or you can get cocktail recipes with your own ingredients.\n"
    # Screen.next
  end

  def self.invalid_option
    print "Please select a valid option.\nInput: "
    Screen.next
    Screen.clear
  end

  def self.main_menu
    print "\n\n\n\nPlease choose the menu.\n1. Find a cocktail by name.\n2. Find possible cocktail with your own liqours.\n3. Find cocktails based on ther ABV.\n4. Exit.\nInput: "
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
      # break
    else
      self.invalid_option
    end
  end

  def self.find_cocktail_by_name_menu
    Screen.clear
    DisplayTable.recipes_table
    self.main_menu
  end

  def self.find_cocktail_by_ingredient_menu
    Screen.clear
    DisplayTable.ingredients_table
    self.main_menu
  end

  def self.find_cocktail_by_abv

  end
end
