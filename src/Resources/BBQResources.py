from Util.BodyParser import BodyParser
from flask_restful import Resource
from flask_jwt import jwt_required, current_identity
from DataLayer.Models.BBQ import BBQ


class BBQResources(Resource):

    @jwt_required()
    def get(self, id=None):
        from DataLayer.DataAccessObject.IDAO.BBQDAO import BBQDAO
        bbqDAO = BBQDAO()
        message = 'BBQ does not exist'
        status = 400
        data = None
        if id:
            user = bbqDAO.read(id)

            if user:
                message = 'BBQ exists'
                status = 200
                data = user.json()

        else:
            users = bbqDAO.readALL()
            message = 'BQQs do not exist'
            data = users
            if len(users) > 0:
                message = 'Users exist'
                status = 200
        return {
                   'message': message,
                   'data': data
               }, status

    @jwt_required()
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
                'key': 'model',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'photo',
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

        newBBQ = BBQ(None, data['name'], data['model'], data['photo'], data['latitude'], data['longitude'])
        from DataLayer.DataAccessObject.IDAO.BBQDAO import BBQDAO
        bbq = BBQDAO()
        status = 400
        message = 'BBQ not created'
        bbqCreated = bbq.create(newBBQ)
        if bbqCreated:
            message = 'BBQ created'
            status = 201

        return {'message': message, 'data': data}, status

    @jwt_required()
    def put(self, id):
        _help = 'This field cannot be blank!'
        data = BodyParser.bodyParser([
            {
                'key': 'name',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'model',
                '_type': str,
                '_required': True,
                '_help': _help
            },
            {
                'key': 'photo',
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
        message = 'Not allowed'
        status = 405
        if id.isdigit():
            bbqToUpdate = BBQ(int(id), data['name'], data['model'], data['photo'], data['latitude'], data['longitude'])

            from DataLayer.DataAccessObject.IDAO.BBQDAO import BBQDAO
            bbqDAO = BBQDAO()
            status = 400
            if bbqDAO.update(bbqToUpdate):
                message = 'BBQ updated'
                status = 201

        return {'message': message, 'data': data}, status

    @jwt_required()
    def delete(self, id):
        message = 'User does not exist to delete'
        status = 400
        if id.isdigit() and current_identity.id == int(id):
            from DataLayer.DataAccessObject.IDAO.BBQDAO import BBQDAO
            bbqDAO = BBQDAO()
            if bbqDAO.delete(id):
                message = 'BBQ deleted successfully'
                status = 202
        else:
            message = 'Not allowed'
            status = 405
        return {'message': message, 'data': {
            'id': id
        }}, status