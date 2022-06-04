import os, logging

from flask import Flask

from app import query, healthcheck

logging.basicConfig(level=logging.INFO)


def create_app():
    '''create and configure the app'''
    app = Flask(__name__,instance_relative_config=True)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    app.register_blueprint(query.bp)
    app.register_blueprint(healthcheck.bp)

    return app
