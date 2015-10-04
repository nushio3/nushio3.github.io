mkdir -p dist
cp publications.tex *.bib *.bst *.sty dist/
cd dist
htlatex publications.tex '' ''
for auxfile in $( ls bu*.aux ); do
    echo bibtex $auxfile
    bibtex $auxfile
done
htlatex publications.tex '' ''
