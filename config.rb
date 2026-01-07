require 'fileutils'
require 'sqlite3'

# 1. File paths
DB_NAME = 'sqlite.db'
DB_FOLDER = 'db'
DB_PATH = File.expand_path(File.join(__dir__, DB_FOLDER, DB_NAME))
          
FileUtils.mkdir_p(File.dirname(DB_PATH))

# 2. Environment check
ENV['RACK_ENV'] ||= 'development'

# 3. Logic to configure the app (to be called from app.rb or config.ru)
def setup_development_features(app_class)
  if ENV['RACK_ENV'] == 'development'
    require 'sinatra/reloader'
    app_class.register Sinatra::Reloader
    app_class.also_reload File.join(__dir__, 'config.rb')
    # Students can add more paths here if they create folders like /models
    puts "♻️  Auto-reload enabled"
  end
end