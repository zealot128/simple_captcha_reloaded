regenerate:
	echo "Regenerating dummy app by spec/template.rb..."
	export TEMPLATE='spec/template.rb'
	export ENGINE='simple_captcha_reloaded'
	bundle exec rake dummy:app
