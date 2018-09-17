from Util.BodyParser import BodyParser
from flask_restful import Resource
from flask_jwt import jwt_required, current_identity
from DataLayer.Models.User import User
from DataLayer.DataAccessObject.Transactions.Transactions import Transactions
from DataLayer.DataAccessObject.IDAO.UserDAO import UserDAO

import hashlib

hashlib.sha256()


class UserResources(Resource):

    @jwt_required()
    def get(self, id=None):
        userDAO = UserDAO()
        message = 'User does not exist'
        status = 400
        data = None
        if id:
            if id.isdigit() and current_identity.id == int(id):
                user = userDAO.read(id)

                if user:
                    message = 'User exists'
                    status = 200
                    data = user.json()
            else:
                message = 'Not allowed'
                status = 405

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
        status = 400
        message = 'User not created'
        if userVerification:
            message = 'User already exists with that email'
            return {'message': message, 'data': {
                'name': userVerification.name,
                'lastName': userVerification.lastName,
                'email': userVerification.email
            }}, status

        if userDAO.create(newUser):
            message = 'User created'
            status = 201
        return {'message': message, 'data': data}, status

    @jwt_required()
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
        message = 'Not allowed'
        status = 405
        if current_identity.id == data['id']:
            userToUpdate = User(data['id'], data['name'], data['lastName'], data['age'], data['email'], None,
                                data['latitude'], data['longitude'])

            userDAO = UserDAO()
            status = 400
            if userDAO.update(userToUpdate):
                message = 'User updated'
                status = 201

        return {'message': message, 'data': data}, status

    @jwt_required()
    def delete(self, id):
        message = 'User does not exist to delete'
        status = 400
        if id.isdigit() and current_identity.id == int(id):
            userDAO = UserDAO()
            if userDAO.delete(id):
                message = 'User deleted successfully'
                status = 202
        else:
            message = 'Not allowed'
            status = 405
        return {'message': message, 'data': {
            'id': id
        }}, status
