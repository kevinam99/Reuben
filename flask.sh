#!/bin/sh
echo "Welcome to this utility. Let's set up your Flask project"

echo "Downloading and installing Flask..."
pip install Flask
echo "Flask has been installed."


echo "Creating project directory structure..."
mkdir my-project
cd my-project
# pwd == my-project/

echo "Writing to requirements..."
touch requirements.txt
pip freeze > requirements.txt
echo "Requirements done."

mkdir my-project/app
mkdir my-project/app/templates

touch myproject/run.py myproject/config.py
cd my-project/app
touch __init__.py views.py
# pwd == my-project/app

cd ..
CONFIG_PY = $'# Enable Flask\'s debugging features. Should be False in production \n DEBUG = True'
echo "$CONFIG_PY" >> config.py
# pwd == my-project/


INIT_PY = $'from flask import Flask\n

# Initialize the app\n
app = Flask(__name__, instance_relative_config=True)
\n
# Load the views \n
from app import views\n

# Load the config file\n
app.config.from_object(\'config\')'

echo "$INIT_PY" >> app/__init__.py

cd app/templates
touch base.html index.html about.html

BASE_HTML=$'
<!DOCTYPE html>\n
<html lang="en">\n
  <head>\n
    <title>{% block title %}{% endblock %}</title>\n
    <!-- Bootstrap core CSS -->\n
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">\n
    <!-- Custom styles for this template -->\n
    <link href="https://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css" rel="stylesheet"> \n
  </head>\n
  <body>\n
    <div class="container"> \n
      <div class="header clearfix"> \n
        <nav>\n
          <ul class="nav nav-pills pull-right">\n
            <li role="presentation"><a href="/">Home</a></li>\n
            <li role="presentation"><a href="/about">About</a></li>\n
            <li role="presentation"><a href="http://flask.pocoo.org" target="_blank">More About Flask</a></li>\n
          </ul>\n
        </nav>\n
      </div>\n
      {% block body %} \n
      {% endblock %}\n
      <footer class="footer">\n
        <p>© 2016 Your Name Here</p>\n
      </footer>\n
    </div> <!-- /container -->\n
  </body>\n
</html>\n
'
echo "$BASE_HTML" >> app/templates/base.html

INDEX_HTML=$'
{% extends "base.html" %}\n
{% block title %}Home{% endblock %}\n
{% block body %}\n
<div class="jumbotron">\n
  <h1>Flask Is Awesome</h1>\n
  <p class="lead">And I\'m glad to be learning so much about it!</p>\n
</div>\n
{% endblock %}\n
'
echo "$INDEX_HTML" >> app/templates/index.html


export FLASK_APP=run.py