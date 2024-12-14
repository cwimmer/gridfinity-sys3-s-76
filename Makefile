.PHONY: install download-gridfinity-rebuilt
install:  download-gridfinity-rebuilt

download-gridfinity-rebuilt:
	@echo "Cleaning up previous Gridfinity rebuilt..."
	@rm -rf gridfinity-rebuilt-openscad-main
	@echo "Downloading Gridfinity rebuilt..."
	@curl -vvv -s --output main.zip -L https://github.com/kennetek/gridfinity-rebuilt-openscad/archive/refs/heads/main.zip
	@unzip -q main.zip
	rm main.zip
