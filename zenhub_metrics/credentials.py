import os

GITHUB = {
    'token': os.getenv('GITHUB_TOKEN',''),
    'owner': os.getenv('GITHUB_USER', 'skyscrapers')
}
ZENHUB = {
    'token': os.getenv('ZENHUB_TOKEN','')
}
