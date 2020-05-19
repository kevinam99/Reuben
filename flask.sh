#!/bin/sh
get_name ()
{
    echo "Okay, first things first. What is your project called?"
    read PROJECT_NAME
    # echo "I got \"$PROJECT_NAME\". Shall I continue with that? (y/n)"
    # read CHOICE
    read -p "I got \"$PROJECT_NAME\". Shall I continue with that? (y/n)"  CHOICE
    # echo $CHOICE
    if [ $CHOICE = y ]
    then
        retval = PROJECT_NAME

    else
        get_name
    fi
}

echo "Welcome to this utility. Let's set up your Flask project."

PROJECT_NAME = "Some shiz"
get_name $PROJECT_NAME
echo $PROJECT_NAME




echo "Downloading and installing Flask..."
# pip install Flask
echo "Flask has been installed."


echo "Creating project directory structure..."
mkdir $PROJECT_NAME
cd $PROJECT_NAME
# pwd == PROJECT_NAME/

echo "Writing to requirements..."
touch requirements.txt
REQUIREMENTS = $'
click>=6.6\n
Flask>=0.11.1\n
itsdangerous>=0.24\n
Jinja2>=2.8\n
MarkupSafe>=0.23\n
Werkzeug>=0.11.11
'
echo "$REQUIREMENTS" > requirements.txt
echo "Requirements done."

mkdir $PROJECT_NAME/app
mkdir $PROJECT_NAME/app/templates

touch $PROJECT_NAME/run.py $PROJECT_NAME/config.py
cd $PROJECT_NAME/app
touch __init__.py views.py
# pwd == PROJECT_NAME/app

cd ..
CONFIG_PY = $'# Enable Flask\'s debugging features. Should be False in production \n DEBUG = True'
echo "$CONFIG_PY" >> config.py
# pwd == PROJECT_NAME/


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

ABOUT_HTML=$'
{% extends "base.html" %}\n
{% block title %}About{% endblock %}\n
{% block body %}\n
<div class="jumbotron">\n
<h1>The About Page</h1>\n
<p class="lead">You can learn more about PROJECT_NAME here.</p>\n
</div>\n
{% endblock %}\n
'

echo "$ABOUT_HTML" >> app/templates/about.html

export FLASK_APP=run.py
export FLASK_ENV=DEVELOPMENT