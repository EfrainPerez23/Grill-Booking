from DataLayer.DataAccessObject.Dependencies.DAO import DAO
from DataLayer.Models.User import User

from DataLayer.DataAccessObject.DataBase.DBManager import DBManager
import hashlib

hashlib.sha256()

class UserDAO(DAO):

    def create(self, user):
        if user.isValid():
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'INSERT INTO User VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
            response = cursor.execute(query, (
                None, user.name, user.lastName, user.age, user.email, user.password, user.latitude, user.longitude))
            if response:
                conn.connection.commit()
                return user

        return None

    def delete(self, _id):
        if _id:
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'DELETE FROM User WHERE idUser = %s'
            response = cursor.execute(query, (_id,))
            if response:
                conn.connection.commit()
                return True
        return False

    def read(self, _id):
        if _id:
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'SELECT idUser, name, lastName, age, email, latitude, longitude FROM User WHERE idUser = %s'
            cursor.execute(query, (_id,))
            firstUser = cursor.fetchone()
            if firstUser:
                user = User(firstUser['idUser'], firstUser['name'], firstUser['lastName'], firstUser['age'], firstUser['email'], '',
                            firstUser['latitude'], firstUser['longitude'])
                return user
            return firstUser
        return None

    def readALL(self):
        conn = DBManager()
        cursor = conn.connection.cursor()
        query = 'SELECT idUser, name, lastName, age, email, latitude, longitude FROM User'
        cursor.execute(query)
        users = cursor.fetchall()
        if users:
            return [
                User(user['idUser'], user['name'], user['lastName'], user['age'], user['email'], '', user['latitude'], user['longitude']).json()
                for user in users
            ]
        return []

    def update(self, user):
        if user and user.isValid():
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'UPDATE User SET name = %s, lastName = %s, age= %s, latitude = %s, longitude = %s, password = %s ' \
                    'WHERE idUser = %s '
            response = cursor.execute(query,
                                      (user.name, user.lastName, user.age, user.latitude, user.longitude,
                                       hashlib.sha224(user.password.encode('utf-8')).hexdigest(), user.id,))
            if response:
                conn.connection.commit()
                return user
        return None
