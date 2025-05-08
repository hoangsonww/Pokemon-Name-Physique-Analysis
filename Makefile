.PHONY: all analysis report clean

# Main R script and R Markdown
SCRIPT    := pokemon_name_physique_analysis.R
RMD       := pokemon_analysis.Rmd

# Outputs
HTML      := pokemon_analysis.html
PDF       := pokemon_analysis.pdf

all: analysis report

analysis:
	Rscript $(SCRIPT)

report: analysis $(PDF)

$(PDF): $(RMD)
	Rscript -e "rmarkdown::render('$(RMD)', output_format='pdf_document', output_file='$(PDF)')"

clean:
	rm -f *.html *.pdf *.aux *.log *.out
