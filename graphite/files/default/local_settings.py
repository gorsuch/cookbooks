import sys, os
from os.path import join, dirname, abspath

# Filesystem layout (all directores should end in a /)
WEB_DIR = dirname( abspath(__file__) ) + '/'
WEBAPP_DIR = dirname( dirname(WEB_DIR) ) + '/'
GRAPHITE_ROOT = dirname( dirname(WEBAPP_DIR) ) + '/'
CONTENT_DIR = WEBAPP_DIR + 'content/'
STORAGE_DIR = '/data/'
WHISPER_DIR = STORAGE_DIR + 'whisper/'
RRD_DIR = STORAGE_DIR + 'rrd/'
LISTS_DIR = STORAGE_DIR + 'lists/'
INDEX_FILE = STORAGE_DIR + 'index'
WHITELIST_FILE = LISTS_DIR + 'whitelist'
LOG_DIR = STORAGE_DIR + 'log/webapp/'

# db configs
DATABASE_ENGINE = 'sqlite3'                     # 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = '/data/db/graphite.db'     # Or path to database file if using sqlite3.
DATABASE_USER = ''                              # Not used with sqlite3.
DATABASE_PASSWORD = ''                          # Not used with sqlite3.
DATABASE_HOST = ''                              # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''                              # Set to empty string for default. Not used with sqlite3.