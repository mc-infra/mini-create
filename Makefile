mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@latest
	clear
	@echo "Packwiz has been Updated"
refresh:
	pw -b -d versions/fabric refresh
	pw -b -d versions/quilt refresh
update:
	pw -b -d versions/fabric update --all
	timeout 5
	pw -b -d versions/quilt update --all
update-fabric:
	pw -b -d versions/fabric update --all
update-quilt:
	pw -b -d versions/quilt update --all
export:
	pw -b -d versions/fabric mr export -o ${ROOT_DIR}/build
	pw -b -d versions/quilt mr export -o ${ROOT_DIR}/build
