build:
	docker build -t device-init .

clean:
	rm -f device-init_*

compile: build clean
	docker run -ti --rm -v $(shell pwd):/opt/gopath/src/github.com/hypriot/device-init -v $(shell pwd)/scripts/build.sh:/build.sh device-init /build.sh

test: build
	docker run -ti --rm --privileged --hostname device-tester -v $(shell pwd)/device-init_linux_amd64:/usr/local/bin/device-init -v $(shell pwd)/specs:/specs device-init rspec --format documentation --color /specs/

compile_and_test: compile test

test-shell: build
	docker run -ti --rm --privileged --hostname device-tester -v $(shell pwd)/device-init_linux_amd64:/usr/local/bin/device-init -v $(shell pwd)/specs:/specs device-init bash

shell: build
	docker run -ti --rm -v $(shell pwd):/opt/gopath/src/github.com/hypriot/device-init -v $(shell pwd)/scripts/build.sh:/build.sh device-init /bin/bash

