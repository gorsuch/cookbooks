default.graphite[:dir]            = "/opt/graphite"
default.graphite[:document_root]  = "/opt/graphite/webapp"
default.graphite[:log_dir]        = "/data/log"
default.graphite[:whisper_dir]    = "/data/whisper"

default.graphite[:carbon_user]    = "carbon"
default.graphite[:wsgi_path]      = "/opt/graphite/webapp/graphite/graphite.wsgi"
default.graphite[:wsgi_user]      = "www-data"
default.graphite[:wsgi_group]     = "www-group"