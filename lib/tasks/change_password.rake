desc "Change Password"
task :change_password => :environment do

  puts "You will be prompted to enter an email address and password to change."
  puts "Enter an email address:"
  email = STDIN.gets
  puts "Enter a password:"
  password = STDIN.gets

  unless email.strip!.blank? || password.blank?
    user = User.find_by_email email
    if user.update(password: password)
      puts "Password was changed for: #{email}"
    else
      puts "Sorry, password was not changed."
    end
  end

end