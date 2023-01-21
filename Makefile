# Helper file for development and testing

# init repo
init:
	pre-commit install
	pre-commit autoupdate
	echo 'ruby-2.7.6' >> .ruby-version
	
install:
	