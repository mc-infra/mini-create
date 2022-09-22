current_dir := $(abspath build)

update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@latest
	clear
	@echo "Packwiz has been Updated"
refresh:
	pw -b -d versions/fabric refresh
	pw -b -d versions/quilt refresh
update:
	pw -b -d versions/fabric update --all -y
	timeout 5
	pw -b -d versions/quilt update --all -y
update-fabric:
	pw -b -d versions/fabric update --all
update-quilt:
	pw -b -d versions/quilt update --all
export:
	pw -b -d versions/fabric mr export -o ${current_dir}/Fabric.mrpack
	pw -b -d versions/quilt mr export -o ${current_dir}/Quilt.mrpack
