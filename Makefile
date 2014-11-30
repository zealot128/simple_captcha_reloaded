regenerate:
	echo "Regenerating dummy app by spec/template.rb..."
	rake app:db:drop
	rm -rf spec/dummy
	export TEMPLATE='spec/template.rb'
	export ENGINE='simple_captcha_reloaded'
	bundle exec rake dummy:app
	bundle exec rake app:db:test:prepare

test_all:
	bundle exec appraisal 'make regenerate && rspec'
