# config.ru
require 'sinatra'
require 'sqlite3'
require 'json'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }

# Create the tables
Database.db.execute "CREATE TABLE IF NOT EXISTS Client(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, phone_number STRING, project_name STRING, budget INTEGER)"
Database.db.execute "CREATE TABLE IF NOT EXISTS Employee(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, phone_number STRING, title STRING)"

# map the controllers to routes
map('/clients') { run ClientController }
map('/employees') { run EmployeeController }
map('/') { run ApplicationController }