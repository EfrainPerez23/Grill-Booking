from Util.BodyParser import BodyParser
from flask_restful import Resource
# from flask_jwt import jwt_required
from DataLayer.Models.User import User
from DataLayer.DataAccessObject.Transactions.Transactions import Transactions
from DataLayer.DataAccessObject.IDAO.UserDAO import UserDAO

import hashlib

hashlib.sha256()


class UserResources(Resource):

    def get(self, id=None):
        userDAO = UserDAO()
        message = 'User does not exist'
        status = 400
        data = None
        if id:
            user = userDAO.read(id)
            if user:
                message = 'User exists'
                status = 200
                data = user.json()
        else:
            users = userDAO.readALL()
            message = 'Users do not exist'
            data = users
            if len(users) > 0:
                message = 'Users exist'
                status = 200
        return {
                   'message': message,
                   'data': data
               }, status

    def post(self, id=None):

        _help = 'This field cannot be blank!'
        data = BodyParser.bodyParser([
            {
                'key': 'name',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'lastName',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'age',
                '_type': int,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'password',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'email',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'latitude',
                '_type': float,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'longitude',
                '_type': float,
                '_required': True,
                '_help': _help
            },

        ])

        encryptedPassword = hashlib.sha224(data['password'].encode('utf-8')).hexdigest()
        newUser = User(None, data['name'], data['lastName'], data['age'], data['email'], encryptedPassword,
                       data['latitude'], data['longitude'])

        userDAO = UserDAO()
        transaction = Transactions()
        userVerification = transaction.findUserByEmail(newUser.email)
        if userVerification:
            return {'message': 'User already exists with that email', 'data': {
                'name': userVerification.name,
                'lastName': userVerification.lastName,
                'email': userVerification.email
            }}, 400

        if userDAO.create(newUser):
            return {'message': 'User created', 'data': data}, 201

        return {'message': 'User not created', 'data': data}, 400

    def put(self, id=None):
        _help = 'This field cannot be blank!'
        data = BodyParser.bodyParser([
            {
                'key': 'id',
                '_type': int,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'name',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'lastName',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'email',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'age',
                '_type': int,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'latitude',
                '_type': float,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'longitude',
                '_type': float,
                '_required': True,
                '_help': _help
            },

        ])
        userToUpdate = User(data['id'], data['name'], data['lastName'], data['age'], data['email'], None,
                            data['latitude'], data['longitude'])

        userDAO = UserDAO()

        if userDAO.update(userToUpdate):
            return {'message': 'User updated', 'data': data}, 201

        return {'message': 'User not updated', 'data': data}, 400

    def delete(self, id):
        userDAO = UserDAO()
        message = 'User does not exist to delete'
        status = 400
        if userDAO.delete(id):
            message = 'User deleted successfully'
            status = 202
        return {'message': message, 'data': {
            'id': id
        }}, status
