from DataLayer.DataAccessObject.DataBase.DBManager import DBManager
from DataLayer.Models.User import User
import hashlib

hashlib.sha256()


class Transactions:

    def findUserByEmail(self, email):
        conn = DBManager()
        cursor = conn.connection.cursor()
        query = 'SELECT idUser, name, age, lastName, password, email, latitude, longitude  FROM User WHERE email = %s'
        cursor.execute(query, (email,))
        userByEmail = cursor.fetchone()
        if userByEmail:
            user = User(userByEmail['idUser'], userByEmail['name'], userByEmail['lastName'], userByEmail['age'],
                        userByEmail['email'], userByEmail['password'], userByEmail['latitude'],
                        userByEmail['longitude'])
            return user
        return None

    def checkOldPassword(self, _id, password):
        if password:
            encryptedPassword = hashlib.sha224(password.encode('utf-8')).hexdigest()
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'SELECT idUser, name, age, lastName, email, latitude, longitude  FROM User WHERE password = %s AND idUser = %s'
            cursor.execute(query, (encryptedPassword, _id,))
            checked = cursor.fetchone()
            if checked:
                return True
        return False
