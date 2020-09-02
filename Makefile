## Build and deploy https://fancheng.me

all: serve

serve:
	Rscript -e "blogdown::serve_site()"

build:
	Rscript -e "blogdown::hugo_build()"

deploy: 
	build
	bash deploy.sh
	
clean:
	rm -rf public
	rm -rf blogdown