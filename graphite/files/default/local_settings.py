# Edit this file to override the default graphite settings, do not edit settings.py!!!

WEB_DIR = dirname( abspath(__file__) ) + '/'
WEBAPP_DIR = dirname( dirname(WEB_DIR) ) + '/'
GRAPHITE_ROOT = dirname( dirname(WEBAPP_DIR) ) + '/'
CONTENT_DIR = WEBAPP_DIR + 'content/'
STORAGE_DIR = GRAPHITE_ROOT + 'storage/'
WHISPER_DIR = STORAGE_DIR + 'whisper/'
RRD_DIR = STORAGE_DIR + 'rrd/'
LISTS_DIR = STORAGE_DIR + 'lists/'
INDEX_FILE = STORAGE_DIR + 'index'
WHITELIST_FILE = LISTS_DIR + 'whitelist'
LOG_DIR = STORAGE_DIR + 'log/webapp/'
CLUSTER_SERVERS = []

DATABASE_ENGINE = 'sqlite3'                     # 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = STORAGE_DIR + 'db/graphite.db'     # Or path to database file if using sqlite3.
DATABASE_USER = ''                              # Not used with sqlite3.
DATABASE_PASSWORD = ''                          # Not used with sqlite3.
DATABASE_HOST = ''                              # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''                              # Set to empty string for default. Not used with sqlite3.

# Turn on debugging and restart apache if you ever see an "Internal Server Error" page
#DEBUG = True

# Set your local timezone (django will try to figure this out automatically)
#TIME_ZONE = 'America/Chicago'

# Setting MEMCACHE_HOSTS to be empty will turn off use of memcached entirely
#MEMCACHE_HOSTS = ['127.0.0.1:11211']

# Sometimes you need to do a lot of rendering work but cannot share your storage mount
#REMOTE_RENDERING = True
#RENDERING_HOSTS = ['fastserver01','fastserver02']
#LOG_RENDERING_PERFORMANCE = True
#LOG_CACHE_PERFORMANCE = True

# If you've got more than one backend server they should all be listed here
#CARBONLINK_HOSTS = ["127.0.0.1:7002"]
#CLUSTER_SERVERS = []

# Override this if you need to provide documentation specific to your graphite deployment
#DOCUMENTATION_URL = "http://wiki.mycompany.com/graphite"

# Enable email-related features
#SMTP_SERVER = "mail.mycompany.com"

# LDAP / ActiveDirectory authentication setup
#USE_LDAP_AUTH = True
#LDAP_SERVER = "ldap.mycompany.com"
#LDAP_SEARCH_BASE = "OU=users,DC=mycompany,DC=com"
#LDAP_BASE_USER = "CN=some_readonly_account,DC=mycompany,DC=com"
#LDAP_BASE_PASS = "readonly_account_password"
#LDAP_USER_QUERY = "(username=%s)"  #For Active Directory use "(sAMAccountName=%s)"

# If sqlite won't cut it, configure your real database here (don't forget to run manage.py syncdb!)
#DATABASE_ENGINE = 'mysql' # or 'postgres'
#DATABASE_NAME = 'graphite'
#DATABASE_USER = 'graphite'
#DATABASE_PASSWORD = 'graphite-is-awesome'
#DATABASE_HOST = 'mysql.mycompany.com'
#DATABASE_PORT = '3306'
