from flask import Flask, current_app, request

app = Flask(__name__)

a = current_app
d = current_app.config['DUBUG']