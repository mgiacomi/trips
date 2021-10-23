desc "Change Password"
task :change_password => :environment do

  raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
  puts "You will be prompted to enter an email address and password to change."
  puts "Enter an email address:"
  email = STDIN.gets
  puts "/users/password/edit?reset_password_token=#{raw}"

  user = User.find_by(email: email.strip)
  user.reset_password_token = hashed
  user.reset_password_sent_at = Time.now.utc
  user.save

end