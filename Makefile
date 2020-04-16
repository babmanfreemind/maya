build:
	docker build -t maya .

dry_run:
	docker run -it -v $(shell pwd):/maya --entrypoint=/bin/bash maya

run_debug:
	docker run -v $(shell pwd):/maya -p 3000:3000 maya

install_gems:
	docker run -v $(shell pwd):/maya maya bundle install

rspec:
	docker run -it -v $(shell pwd):/maya -e RAILS_ENV=test --entrypoint=rspec maya
