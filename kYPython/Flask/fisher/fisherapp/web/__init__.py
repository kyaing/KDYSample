from flask import Blueprint

# 蓝图 blueprint
web = Blueprint('web', __name__)

from fisherapp.web import book
from fisherapp.web import user