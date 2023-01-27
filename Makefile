# Helper file for development and testing

# init repo
init:
	pre-commit install
	pre-commit autoupdate
	echo 'ruby-2.7.6' >> .ruby-version

install:
	brew install pre-commit
	brew install rbenv
	rbenv install 2.7.6
	bundle install

# run tests
test:
	bundle exec kitchen test debian-11-master-py3