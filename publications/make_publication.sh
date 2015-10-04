mkdir -p dist
htlatex publications.tex '' '' -ddist/
bibtex publications
htlatex publications.tex '' '' -ddist/
