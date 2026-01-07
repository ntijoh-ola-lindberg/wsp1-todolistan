require 'sqlite3'
require_relative '../config'

class Seeder

  def self.seed!

    @db = nil

    puts "Using db file: #{DB_PATH}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos')
  end

  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL, 
                description TEXT,
                completed INTEGER DEFAULT 0 )')
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko", 1)')
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Köp julgran", "En rödgran", 0)')
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0)')
  end

end
