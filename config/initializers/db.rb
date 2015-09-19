require 'sequel'
require 'logger'

db_config = {
  adapter: 'mysql2',
  host: 'localhost',
  user: 'root',
  database: 'scoring'
}
DB = Sequel.connect(db_config)
DB.loggers << Logger.new($stdout)
