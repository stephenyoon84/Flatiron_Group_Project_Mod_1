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
    puts "Art".green
    print "Welcome to Get Your Cocktail! You can search what kind of ingredients you need to make cocktail you want or you can get cocktail recipes with your own ingredients.\n"
    Screen.next
  end

  def self.invalid_option
    print "Please select a valid option.\nInput: "
    Screen.next
    Screen.clear
  end
end
