import logging

from flask import Blueprint, Response
from app.counter import CountReocurrenceChar


bp = Blueprint('healthcheck',__name__,url_prefix='/')

@bp.route('/healthcheck')
def get():
    '''Creating the healthcheck entrypoint'''
    logging.info('GET /healthcheck')
    return Response('OK', status=200)
