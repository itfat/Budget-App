# Imports
import firebase_admin
from flask.helpers import url_for
from flask.templating import render_template
import pyrebase
import json
from firebase_admin import credentials
from firebase_admin import auth
from flask import Flask, request, flash
from werkzeug.utils import redirect
# App configuration
app = Flask(__name__)
# Connect to firebase
cred = credentials.Certificate('adminConfig.json')
firebase = firebase_admin.initialize_app(cred)
pb = pyrebase.initialize_app(json.load(open('config.json')))
# Data source
users = [{'uid': 1, 'name': 'Noah Schairer'}]
# Api route to get users


# Home Page
@app.route('/')
def home():
    return render_template('home.html')

# Sign Up
@app.route('/signup')
def newuser():
    return render_template('login.html')

# API Sign Up
@app.route('/api/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        print(email)
        print(password)
        if email is None or password is None:
            msg = 'Error missing email or password'
        try:
            user = pb.auth().create_user_with_email_and_password(
                email=email,
                password=password
            )
            print(user)
            msg = 'Successfully created user '
            print(msg)
        except:
            msg = 'There was an error creating user'
    print(msg)
    return render_template("result.html",)


def check_token(f):
    # @wraps(f)
    def wrap(*args, **kwargs):
        if not request.headers.get('authorization'):
            return {'message': 'No token provided'}
        try:
            user = auth.verify_id_token(request.headers['authorization'])
            request.user = user
        except:
            return {'message': 'Invalid token provided.'}
        return f(*args, **kwargs)
    return wrap


@app.route('/api/userinfo')
@check_token
def userinfo():
    return {'data': users}
# Api route to sign up a new user


# Api route to get a new token for a valid user


@app.route('/api/token')
def token():
    email = request.form.get('email')
    password = request.form.get('password')
    try:
        user = pb.auth().sign_in_with_email_and_password(email, password)
        jwt = user['idToken']
        return {'token': jwt}
    except:
        return {'message': 'There was an error logging in'}


if __name__ == '__main__':
    app.run(debug=True)
