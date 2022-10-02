current_dir := $(abspath build)

loaders := forge fabric quilt

lr := $(foreach loader, ${loaders}, versions/${loader})

update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/mc-infra/packwiz-wrapper/cmd/pw@latest
	clear
	@echo "Packwiz has been Updated"

add-forge:
	pw -c -y -d versions/forge/1.19.2 -i ./data/forge/client.txt
add-quilt:
	pw -c -y -d versions/quilt/1.18.2 -i ./data/quilt/client.txt
	pw -y -d versions/quilt/1.18.2 -i ./data/quilt/common.txt
	pw -y -d versions/quilt/1.18.2 -i ./data/quilt/deco.txt
refresh:
	pw -b -d versions/forge refresh
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
