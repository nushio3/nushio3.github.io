all:post/index.html

post/index.html: post.tex references.bib
	platex post.tex
	bibtex post
	platex post.tex
	platex post.tex
	latex2html post.tex
