.PHONY: install
install:
	bundle config set --local path 'vendor/bundle'
	bundle install

.PHONY: release
release:
	bundle exec rake release

.PHONY: test
test:
	bundle exec rspec spec
