class AccountHelper
  def self.inputPW(user_input)
    prompt = TTY::Prompt.new
    user_input2 = prompt.mask("Please enter your User PW: ")
    if self.validPW?(user_input, user_input2)
      puts "Welcome back #{User.find_by(user_name: user_input).name}. Good to see you again.\nPress any key to go to the Main menu.\n"
      Screen.next
      Screen.clear
      CocktailApp.main_menu
    else
      puts "Wrong password. Pleaes try again."
      self.inputPW(user_input)
    end
  end

  def self.validID?(user_input)
    !!User.find_by(user_name: user_input)
  end

  def self.validPW?(user_input, user_input2)
    User.find_by(user_name: user_input).try(:authenticate, user_input2)
  end

  def self.signin
    print "\nPlease enter User ID: "
    user_input = gets.chomp
    if self.validID?(user_input)
      print "Sorry. This ID is already taken."
      self.signin
    else
      new_user = User.new(user_name: user_input)
      print "\nYour user ID is available.\nPleaes enter you name: "
      user_input2 = gets.chomp
      # new_user.name = user_input2
      print "\nHello, #{user_input2}.\n"
      prompt = TTY::Prompt.new
      user_input3 = prompt.mask("Please enter your PW: ")
      new_user.password = user_input3
      user_input4 = prompt.mask("Please re-enter your PW for confirmation: ")
      if user_input3 == user_input4
        new_user.password_confirmation = user_input4
        new_user.name = user_input2
        new_user.save
      else
        print "Your PW is not matching. Please try again."
        self.signin
      end
    end
  end

  def self.login
    Screen.clear
    Artscii.welcome
    print "\nPlease enter your User ID: "
    user_input = gets.chomp
    if self.validID?(user_input)
      self.inputPW(user_input)
    else
      puts "We can not find your ID. Please check and try again."
      Screen.next
      self.login
    end
  end
end
