desc "Setup Admin"
task :setup_admin => :environment do

  puts "You will be prompted to enter an email address and password for the new admin"
  puts "Enter an email address:"
  email = STDIN.gets
  password = SecureRandom.urlsafe_base64(6)

  unless email.strip!.blank? || password.blank?
    if User.create!(email: email, password: password, admin: true)
      puts "The admin was created successfully. #{email} #{password}"
    else
      puts "Sorry, the admin was not created!"
    end
  end

end