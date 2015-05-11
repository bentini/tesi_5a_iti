echo Compilazione di documenti latex
pdflatex *.tex 
pdflatex *.tex
rm *.log
rm *.aux
rm *.toc
rm *.idx
rm *.out
echo Terminato OK
