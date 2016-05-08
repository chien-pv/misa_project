db_conf = YAML::load(File.open(File.join('config','database_load.yml')))
DB_CONF = db_conf["db_misa"]