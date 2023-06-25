#!/bin/bash

echo "🏁  Starting the cookie cutter script."

echo "ℹ️ Creating GitHub repository and initialize the git."
gh repo create {{cookiecutter.github_url}}/{{cookiecutter.github_org}}/{{cookiecutter.project_slug}} --public
echo "✅  Repository created."
git init
git remote add origin git@{{cookiecutter.github_url}}:{{cookiecutter.github_org}}/{{cookiecutter.project_slug}}.git
git branch -M main
echo "✅  Git has been initialized."

echo "ℹ️  Starting installing the NPM packages."
npm install
echo "✅  Starting installing the NPM packages."

echo "ℹ️  Pushing all of the code to Github"
git add .
git commit -m "feat: setup of the repository"
git push origin main
echo "✅  Code now available at https://{{cookiecutter.github_url}}/{{cookiecutter.github_org}}/{{cookiecutter.project_slug}}"

echo "ℹ️ Setting up the Travis environment variable."
travis env set SONAR_TOKEN {{cookiecutter.__sonar_token}} --private -e "https://v3.travis.ibm.com/api" -r {{cookiecutter.github_org}}/{{cookiecutter.project_slug}}
travis env set SNYK_TOKEN {{cookiecutter.__snyk_token}} --private -e "https://v3.travis.ibm.com/api" -r {{cookiecutter.github_org}}/{{cookiecutter.project_slug}}
echo "✅  Starting installing the NPM packages."

code .

echo "🚀  Completed the cookie cutter script"
