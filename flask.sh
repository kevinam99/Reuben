#!/bin/sh
echo "Welcome to this utility. Let's set up your Flask project"

echo "Downloading and installing Flask..."
pip install Flask
echo "Flask has been installed."

echo "Writing to requirements..."
touch requirements.txt
pip freeze > requirements.txt
echo "Requirements done."
