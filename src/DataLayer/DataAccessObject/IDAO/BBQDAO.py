from DataLayer.DataAccessObject.DataBase.DBManager import DBManager
from DataLayer.DataAccessObject.Dependencies.DAO import DAO
from flask_jwt import current_identity
from DataLayer.Models.BBQ import BBQ


class BBQDAO(DAO):

    def create(self, bbq):
        if bbq and bbq.isValid():
            conn = DBManager()
            cursor = conn.connection.cursor()
            response = cursor.callproc('rentBBQ', (
                bbq.name, bbq.model, bbq.photo, bbq.latitude, bbq.longitude, bbq.favorite, bbq.placeId, current_identity.id))
            if response:
                conn.connection.commit()
                return bbq

        return None

    def delete(self, _id):
        deleted = False
        if _id:
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'DELETE FROM Rent WHERE BBQ_idBBQ = %s AND User_idUser = %s'
            response = cursor.execute(query, (_id, current_identity.id))
            if response:
                conn.connection.commit()
                deleted = True
        return deleted

    def read(self, _id):
        if _id:
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'SELECT idBBQ, name, model, photo, latitude, longitude, favorite, placeId FROM BBQ WHERE idBBQ = %s'
            cursor.execute(query, (_id,))
            firstBBQ = cursor.fetchone()
            if firstBBQ:
                bbq = BBQ(firstBBQ['idBBQ'], firstBBQ['name'], firstBBQ['model'], firstBBQ['photo'],
                          firstBBQ['latitude'], firstBBQ['longitude'], bool(firstBBQ['favorite']), firstBBQ['placeId'])
                return bbq
            return firstBBQ
        return None

    def readALL(self):
        conn = DBManager()
        cursor = conn.connection.cursor()
        query = 'SELECT idBBQ, name, model, photo, latitude, longitude, favorite, placeId FROM BBQ'
        cursor.execute(query)
        bbqs = cursor.fetchall()
        if bbqs:
            return [
                BBQ(bbq['idBBQ'], bbq['name'], bbq['model'], bbq['photo'],
                    bbq['latitude'], bbq['longitude'], bool(bbq['favorite']), bbq['placeId']).json()
                for bbq in bbqs
            ]
        return []

    def update(self, bbq):
        if bbq and bbq.isValid():
            conn = DBManager()
            cursor = conn.connection.cursor()
            query = 'UPDATE BBQ SET name = %s, model = %s, photo= %s, latitude = %s, longitude = %s, favorite = %s WHERE idBBQ = %s'
            response = cursor.execute(query,
                                      (bbq.name, bbq.model, bbq.photo, bbq.latitude, bbq.longitude, bbq.favorite, bbq.id))
            if response:
                conn.connection.commit()
                return bbq
        return None
