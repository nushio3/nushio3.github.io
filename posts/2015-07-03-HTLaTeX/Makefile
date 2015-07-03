all:post/index.html

post/index.html: post.tex references.bib Makefile
	mkdir -p dist
	htlatex post.tex "" "" -ddist/
	bibtex post
	htlatex post.tex "" "" -ddist/
	pdflatex post.tex
	cat metadata.md dist/post.html > dist/post.html.2
	mv dist/post.html.2 dist/post.html
