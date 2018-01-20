namespace :test do
  desc "Setup free plan to new users"
  task :p => :environment do
    get_events
  end
end

def get_events
  system("cd eth/")
  system("venv/bin/python app.py --owner 0x05e7042c3C0753e5B506262047a3D327d3Ac0563 --tx 101 --title 'Finallyy !!!'")
end
