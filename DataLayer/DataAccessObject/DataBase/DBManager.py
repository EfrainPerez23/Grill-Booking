import pymysql
database_name = "heroku_65d1aa2fb6c88c0"
database_host = "us-cdbr-iron-east-01.cleardb.net"
database_port = 3306
database_username = "bf5d98fb7a8b73"
database_password = "f2e32801"


class DBManager(object):

    def __init__(self):
        self.connection = pymysql.connect(host=database_host,
                                          user=database_username,
                                          password=database_password,
                                          db=database_name,
                                          port=database_port,
                                          charset='utf8mb4',
                                          cursorclass=pymysql.cursors.DictCursor)
