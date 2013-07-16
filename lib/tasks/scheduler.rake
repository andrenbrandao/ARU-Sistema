task :check_inactivity => :environment do
  puts "Checking for inactivity of Republicas..."
  Republica.check_inactivity
  puts "done."
end