all:post/index.html

post/index.html: post.tex references.bib Makefile
	htlatex post.tex
	bibtex post
	htlatex post.tex
	pdflatex post.tex
