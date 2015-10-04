mkdir -p dist
cp publications.tex *.bib *.bst *.sty *.cfg dist/
cd dist
htlatex publications.tex  "jppp,xhtml,charset=utf-8" " -cunihtf -utf8"
for auxfile in $( ls bu*.aux ); do
    echo bibtex $auxfile
    bibtex $auxfile
done
htlatex publications.tex  "jppp,xhtml,charset=utf-8" " -cunihtf -utf8"
