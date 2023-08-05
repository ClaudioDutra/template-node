#!/bin/bash

# shellcheck disable=SC3000-SC4000

replace_string_in_file_path() {
    file_path="$1"
    search_string="$2"
    replace_string="$3"

    temp_file_path="$(mktemp)"

    while IFS= read -r line || [ -n "$line" ]; do
        replaced_line="${line//$search_string/$replace_string}"

        echo "$replaced_line" >>"$temp_file_path"
    done <"$file_path"

    mv "$temp_file_path" "$file_path"
}

get_kata_description() {
    kata_id=$1

    codewars_data=$(curl https://www.codewars.com/api/v1/code-challenges/${kata_id})

    echo $codewars_data | jq -Rnr '[inputs] | join("\\n") | fromjson | .description'

}

echo "🏁  Starting the cookie cutter script."

if [ '{{cookiecutter.is_codewars_kata}}' == 'True' ]; then
    echo "ℹ️  Adding Codewars kata description."
    kata_description=$(get_kata_description {{cookiecutter.codewars_kata_code}})
    replace_string_in_file_path "NOTES.md" "\$CODEWARS_KATA_DESCRIPTION" "${kata_description}"
    echo "✅ Codewars kata description added."
else
    replace_string_in_file_path "NOTES.md" "\$CODEWARS_KATA_DESCRIPTION" ""
fi

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
