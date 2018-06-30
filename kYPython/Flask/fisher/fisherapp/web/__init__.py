from flask import Blueprint

# 蓝图 blueprint
web = Blueprint('web', __name__)

from fisherapp.web import book
from fisherapp.web import auth
from fisherapp.web import drift
from fisherapp.web import gift
from fisherapp.web import main
from fisherapp.web import wish