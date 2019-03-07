class AccountHelper
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

  def self.inputPW(user_input)
    prompt = TTY::Prompt.new
    user_input2 = prompt.mask("Please enter your User PW: ")
    if self.validPW?(user_input, user_input2)
      puts "Welcome back #{User.find_by(user_name: user_input).name}. Good to see you again.\nPress any key to go to the Main menu.\n"
      Screen.next
      Screen.clear
      CocktailApp_User.main_menu(user_input)
    else
      puts "Invalid username or password. Pleaes try again."
      Screen.next
      self.login
    end
  end

  def self.validID?(user_input)
    !!User.find_by(user_name: user_input)
  end

  def self.validPW?(user_input, user_input2)
    !!User.find_by(user_name: user_input).try(:authenticate, user_input2)
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
        print "Your Password is not matching. Please try again."
        self.signin
      end
    end
  end

  def self.change_name(user_name)
    user = User.find_by(user_name: user_name)
    print "Please enter your new name: "
    user_input = gets.chomp
    user.update(name: user_input)
    print "Your name has changed to #{user_input}."
  end

  def self.change_password(user_name)
    user = User.find_by(user_name: user_name)
    prompt = TTY::Prompt.new
    user_input = prompt.mask("Please enter your Password: ")
    user_new_pw = prompt.mask("Please enter your new password: ")
    user_new_pw_con = prompt.mask("Please re-enter your new password: ")
    if self.validPW?(user_name, user_input) && user_new_pw == user_new_pw_con
      user.update(password: user_new_pw)
      print "Your password has changed."
      Screen.next
    else
      print "Invalid input. Please try again later."
      Screen.next
    end
  end

  def self.signout(user_name)
    user = User.find_by(user_name: user_name)
    prompt = TTY::Prompt.new
    user_input = prompt.mask("Please enter your Password: ")
    if self.validPW?(user_name, user_input)
      print "Are you sure to sign out? (y/n): "
      user_input2 = gets.chomp
      case user_input2
      when "y", "Y", "Yes", "YES"
        print "Hope to see you again later."
        user.delete
        Screen.next
        Screen.clear
        Artscii.goodbye
      when "n", "N", "No", "NO"
        print "Thank you for staying with us."
        Screen.next
        Screen.clear
        CocktailApp_User.main_menu(user_name)
      else
        CocktailApp.invalid_option
        self.signout(user_name)
      end
    else
      print "Invalid password. Please try again later.\n"
      self.signout(user_name)
    end
  end

end
