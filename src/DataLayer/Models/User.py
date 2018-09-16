from DataLayer.DataAccessObject.Dependencies.DTO import DTO


class User(DTO):

    def __init__(self, _id, name, lastName, age, email, password, latitude, longitude):
        self.id = _id
        self.name = name
        self.lastName = lastName
        self.password = password
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.age = age

    def isValid(self):
        if self.name and self.lastName and self.email:
            return True
        return False

    def json(self):
        return {
            'id': self.id,
            'name': self.name,
            'lastName': self.lastName,
            'password': self.password,
            'email': self.email,
            'latitude': self.latitude,
            'longitude': self.longitude
        }
