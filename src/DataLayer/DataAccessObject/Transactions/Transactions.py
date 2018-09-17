from DataLayer.DataAccessObject.DataBase.DBManager import DBManager
from DataLayer.Models.User import User


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
