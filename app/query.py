import logging

from flask import Blueprint, request, Response
from app.counter import CountReocurrenceChar


bp = Blueprint('query',__name__,url_prefix='/')

@bp.route('/query')
def get():
    '''Creating the entrypoint'''
    logging.info('GET /query')
    param = request.args.get('param')

    if len(param) < 2:
        result = 'Error %s is an invalid Input' % param
        logging.error(result)
        status = 500
    else:
        result = 'Reasult: The amount of reoccurrence characters in %s is %s' % \
            (param, CountReocurrenceChar(param).run())
        logging.info(result)
        status = 200

    return Response(result, status)
