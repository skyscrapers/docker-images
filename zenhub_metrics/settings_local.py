import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.' + os.getenv('DB_BACKEND', 'postgresql'),
        'NAME': os.getenv('DB_NAME', 'zenhub_charts'),
        'USER': os.getenv('DB_USER', 'postgres'),
        'PASSWORD': os.getenv('DB_PASSWORD', ''),
        'HOST': os.getenv('DB_HOST','localhost'),
        'PORT': os.getenv('DB_PORT','5432')
    }
}

REDIS_HOST = os.getenv('REDIS_HOST', 'localhost')
CELERY_BROKER_URL = 'redis://' + REDIS_HOST + ':6379/0'

DEBUG = True
