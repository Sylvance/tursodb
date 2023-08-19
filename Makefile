.PHONY: console
console:
	bin/console

.PHONY: install
install:
	bundle config set --local path 'vendor/bundle'
	bundle install

.PHONY: lint
lint:
	bundle exec rubocop -A

.PHONY: release
release:
	bundle exec rake release

.PHONY: test
test:
	bundle exec rspec spec
