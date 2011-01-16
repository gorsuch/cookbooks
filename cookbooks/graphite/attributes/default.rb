default.graphite[:deb_cache]      = "/root/cache"

default.graphite[:whisper_deb_version] = "0.9.6-1_all"
default.graphite[:carbon_deb_version] = "0.9.6-1_all"
default.graphite[:graphite_deb_version] = "0.9.6-1_all"
default.graphite[:deb_source]     = "https://s3.amazonaws.com/gorsuch-dpkg"

default.graphite[:dir]            = "/opt/graphite"
default.graphite[:document_root]  = default.graphite[:dir] + "/webapp"

default.graphite[:storage_dir]    = "/data"
default.graphite[:db_dir]         = default.graphite[:storage_dir]  + "/db"
default.graphite[:log_dir]        = default.graphite[:storage_dir]  + "/log"
default.graphite[:rrd_dir]        = default.graphite[:storage_dir]  + "/rrd"
default.graphite[:lists_dir]      = default.graphite[:storage_dir]  + "/lists"
default.graphite[:whisper_dir]    = default.graphite[:storage_dir]  + "/whisper"

default.graphite[:index_file]     = default.graphite[:storage_dir]  + "/index"
default.graphite[:whitelist_file] = default.graphite[:storage_dir]  + "/lists/whitelist"

default.graphite[:carbon_user]    = "carbon"
default.graphite[:wsgi_path]      = default.graphite[:document_root] + "/graphite/graphite.wsgi"
default.graphite[:wsgi_user]      = "www-data"
default.graphite[:wsgi_group]     = "www-data"

default.graphite[:db_engine]      = "sqlite3"
default.graphite[:db_name]        = default.graphite[:db_dir] + "/graphite.db"
default.graphite[:db_username]    = ""
default.graphite[:db_password]    = ""
default.graphite[:db_host]        = ""
default.graphite[:db_port]        = ""