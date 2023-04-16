#!/bin/bash

echo "🏁  Starting the cookie cutter script"
gh repo create {{cookiecutter.github_url}}/{{cookiecutter.github_org}}/{{cookiecutter.project_slug}} --public
git init
git remote add origin git@{{cookiecutter.github_url}}:{{cookiecutter.github_org}}/{{cookiecutter.project_slug}}.git
git branch -M main
echo "ℹ️  Starting installing the NPM packages"
npm install
echo "✅  Starting installing the NPM packages"

echo "ℹ️  Pushing all of the code to Github"
git add .
git commit -m "feat: setup of the repository"
git push origin main
echo "✅  Code now available at https://{{cookiecutter.github_url}}/{{cookiecutter.github_org}}/{{cookiecutter.project_slug}}"

code .

echo "🚀  Completed the cookie cutter script"
