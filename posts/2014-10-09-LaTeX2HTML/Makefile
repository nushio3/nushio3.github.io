all:post/index.html

post/index.html: post.tex references.bib Makefile
	pdflatex post.tex -output-format=dvi
	bibtex post
	pdflatex post.tex -output-format=dvi
	pdflatex post.tex -output-format=dvi
	latex2html -no_navigation -split 0 post.tex
	pdflatex post.tex 
	mv post.pdf post/