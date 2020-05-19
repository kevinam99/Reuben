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

