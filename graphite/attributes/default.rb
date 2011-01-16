default.graphite[:deb_cache]      = "/root/cache"

default.graphite[:whisper_deb_version] = "0.9.6-1_all"
default.graphite[:carbon_deb_version] = "0.9.6-1_all"
default.graphite[:graphite_deb_version] = "0.9.6-1_all"
default.graphite[:deb_source]     = "https://s3.amazonaws.com/gorsuch-dpkg"

default.graphite[:dir]            = "/opt/graphite"
default.graphite[:document_root]  = "/opt/graphite/webapp"

default.graphite[:db_dir]         = "/data/db"
default.graphite[:log_dir]        = "/data/log"
default.graphite[:rrd_dir]        = "/data/rrd"
default.graphite[:lists_dir]      = "/data/lists"
default.graphite[:storage_dir]    = "/data"
default.graphite[:whisper_dir]    = "/data/whisper"

default.graphite[:index_file]     = "/data/index"
default.graphite[:whitelist_file] = "/data/lists/whitelist"

default.graphite[:carbon_user]    = "carbon"
default.graphite[:wsgi_path]      = "/opt/graphite/webapp/graphite/graphite.wsgi"
default.graphite[:wsgi_user]      = "www-data"
default.graphite[:wsgi_group]     = "www-data"

default.graphite[:db_engine]      = "sqlite3"
default.graphite[:db_name]        = "/data/db/graphite.db"
default.graphite[:db_username]    = ""
default.graphite[:db_password]    = ""
default.graphite[:db_host]        = ""
default.graphite[:db_port]        = ""