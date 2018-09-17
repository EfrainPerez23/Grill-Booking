from DataLayer.DataAccessObject.Dependencies.DTO import DTO


class BBQ(DTO):

    def __init__(self, _id, name, model, photo, latitude, longitude, favorite):
        self.id = _id
        self.name = name
        self.model = model
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
        self.favorite = favorite

    def isValid(self):
        if self.name and self.model:
            return True
        return False

    def json(self):
        return {
            'id': self.id,
            'name': self.name,
            'model': self.model,
            'photo': self.photo,
            'latitude': self.latitude,
            'longitude': self.longitude,
            'favorite': self.favorite
        }
