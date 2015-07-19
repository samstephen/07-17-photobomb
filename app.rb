
require 'rubygems'
require 'bundler/setup'

require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/json'
require 'bcrypt'


#setting up database
configure :development do
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'database.db')
end

configure :production do
  require 'pg'
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end

# So that ActiveRecord explains the SQL it's running in the logs.
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

require_relative 'database_setup.rb'

# Models
require_relative 'models/tasks.rb'

# Controllers
require_relative 'controllers/main.rb'

# create rows for resource_types
#ResourceType.add({ id: 1, category: "video" })