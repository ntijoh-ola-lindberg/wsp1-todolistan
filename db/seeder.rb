require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

puts "Använder databasen: #{DB_PATH}"
puts "🧹 Tar bort gamla tabeller..."
db.execute('DROP TABLE IF EXISTS todos')
db.execute('DROP TABLE IF EXISTS categories')

puts "🧱 Skapar tabeller..."
db.execute('CREATE TABLE "todos" (
                    "id" INTEGER NOT NULL UNIQUE,
                    "todo_title" TEXT NOT NULL,
                    "todo_description" TEXT NOT NULL,
                    "is_completed" INTEGER NOT NULL DEFAULT 0,
                    "category_id" INTEGER,
                    PRIMARY KEY("id" AUTOINCREMENT),
                    FOREIGN KEY("category_id") REFERENCES "categories"("id")
                    );')

db.execute('CREATE TABLE "categories" (
	                    "id" INTEGER NOT NULL UNIQUE,
                      "category_title" TEXT,
	                    PRIMARY KEY("id" AUTOINCREMENT)
                    );')

puts "🍎 Fyller på med data..."
categories = [
      { category_title: 'Blandat' },
      { category_title: 'Privat' },
      { category_title: 'Köp' },
      { category_title: 'Jobb' }
    ]

categories.each do |c|
  db.execute('INSERT INTO categories (category_title) VALUES (?)',
              c[:category_title])
end

todos = [
      { todo_title: 'Första todon', todo_description: 'Beskrivning av första todon', is_completed: 1, category_id: 1 },
      { todo_title: 'Laga pannkakor', todo_description: '2 1/2 dl vetemjöl - 1/2 tsk salt - 6 dl mjölk - 3  ägg', is_completed: 0, category_id: 2 },
      { todo_title: 'Mjölk', todo_description: 'Två liter', is_completed: 0, category_id: 3 },
      { todo_title: 'Ägg', todo_description: 'Ett tjog', is_completed: 0, category_id: 3 },
      { todo_title: 'Mjöl', todo_description: 'Fyra kg', is_completed: 0, category_id: 3 },
      { todo_title: 'Smör', todo_description: 'Inte margarin', is_completed: 0, category_id: 3 },
      { todo_title: 'Rensa e-mail', todo_description: 'Töm hela inboxen', is_completed: 0, category_id: 4 }
    ]

todos.each do |todo|
  db.execute('INSERT INTO todos (todo_title, todo_description, is_completed, category_id) VALUES (?,?,?,?)',
              [todo[:todo_title], todo[:todo_description], todo[:is_completed], todo[:category_id]])
end
puts "✅ Databasen är seedad!"