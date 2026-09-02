require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

puts "Använder databasen: #{DB_PATH}"
puts "🧹 Tar bort gamla tabeller..."
db.execute('DROP TABLE IF EXISTS todos')

puts "🧱 Skapar tabeller..."
db.execute('CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL, 
            description TEXT,
            completed INTEGER DEFAULT 0 )')

puts "🍎 Fyller på med data..."
db.execute('INSERT INTO todos (name, description, completed) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko", 1)')
db.execute('INSERT INTO todos (name, description, completed) VALUES ("Köp julgran", "En rödgran", 0)')
db.execute('INSERT INTO todos (name, description, completed) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0)')

puts "✅ Databasen är seedad!"