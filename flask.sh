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
echo Creating project \"$PROJECT_NAME\"




echo "Downloading and installing Flask..."
# pip install Flask
echo "Flask has been installed."


echo "Creating project directory structure..."
mkdir $PROJECT_NAME
cd $PROJECT_NAME
# pwd == PROJECT_NAME/

echo "Writing to requirements..."
touch requirements.txt

echo "click>=6.6
Flask>=0.11.1
itsdangerous>=0.24
Jinja2>=2.8
MarkupSafe>=0.23
Werkzeug>=0.11.1" >> requirements.txt

# printf $REQUIREMENTS >> requirements.txt

echo "Requirements done."
mkdir app
mkdir app/templates
cd ../

touch $PROJECT_NAME/run.py $PROJECT_NAME/config.py
cd $PROJECT_NAME/app
touch __init__.py views.py
# pwd == PROJECT_NAME/app

cd ../

echo "# Enable Flask\'s debugging features. Should be False in production
DEBUG = True" >> config.py
echo "config.py written..."

echo "from app import app

if __name__ == '__main__':
    app.run()" >> run.py

# echo $CONFIG_PY >> config.py
# pwd == PROJECT_NAME/


echo "from flask import Flask
# Initialize the app
app = Flask(__name__, instance_relative_config=True)

# Load the views 
from app import views

# Load the config file
app.config.from_object('config')" >> app/__init__.py

# echo "$INIT_PY" >> app/__init__.py

cd app/templates
pwd
touch ./base.html ./index.html ./about.html


echo " <!-- base.html -->
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <title>{% block title %}{% endblock %}</title>
    <!-- Bootstrap core CSS -->
    <link href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\" rel=\"stylesheet\">
    <!-- Custom styles for this template -->
    <link href=\"https://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css\" rel=\"stylesheet\"> 
</head>
<body>
    <div class=\"container\"> 
    <div class=\"header clearfix\"> 
        <nav>
        <ul class=\"nav nav-pills pull-right\">
            <li role=\"presentation\"><a href=\"/\">Home</a></li>
            <li role=\"presentation\"><a href=\"/about\">About</a></li>
            <li role=\"presentation\"><a href=\"http://flask.pocoo.org\" target=\"_blank\">More About Flask</a></li>
        </ul>
        </nav>
    </div>
    {% block body %} 
    {% endblock %}
    <footer class=\"footer\">
        <p>© 2016 Your Name Here</p>
    </footer>
    </div> <!-- /container -->
</body>
</html>
" >> app/templates/base.html
# echo "$BASE_HTML" >> app/templates/base.html

echo "{% extends \"base.html\" %}
{% block title %}Home{% endblock %}
{% block body %}
<div class=\"jumbotron\">
<h1>Flask Is Awesome</h1>
<p class=\"lead\">And I\'m glad to be learning so much about it!</p>
</div>
{% endblock %}
" >> app/templates/index.html

echo "index.html created."
# echo "$INDEX_HTML" >> app/templates/index.html

echo "{% extends \"base.html\" %}
{% block title %}About{% endblock %}
{% block body %}
<div class=\"jumbotron\">
<h1>The About Page</h1>
<p class=\"lead\">You can learn more about PROJECT_NAME here.</p>
</div>
{% endblock %}
" >> app/templates/about.html

echo "about.html created"

# echo "$ABOUT_HTML" >> app/templates/about.html

export FLASK_APP=run.py
export FLASK_ENV=DEVELOPMENT