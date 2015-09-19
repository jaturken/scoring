require 'sequel'

db_config = {
  adapter: 'mysql2',
  host: 'localhost',
  user: 'root',
  database: 'scoring'
}
DB = Sequel.connect(db_config)
