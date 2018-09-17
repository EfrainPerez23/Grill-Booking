from werkzeug.security import safe_str_cmp
import hashlib

from DataLayer.DataAccessObject.IDAO.UserDAO import UserDAO
from DataLayer.DataAccessObject.Transactions.Transactions import Transactions

hashlib.sha256()


def authenticate(email, password):
    userDao = Transactions()
    user = userDao.findUserByEmail(email)
    encryptedPassword = hashlib.sha224(password.encode('utf-8')).hexdigest()
    if user and safe_str_cmp(user.password, encryptedPassword):
        return user


def identity(payload):
    userDao = UserDAO()
    return userDao.read(payload['identity'])
