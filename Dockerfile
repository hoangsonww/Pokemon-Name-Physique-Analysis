# Use official R image
FROM r-base:4.3.2

# Install system dependencies for rendering PDF via rmarkdown
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    texlive-latex-base texlive-fonts-recommended texlive-latex-extra \
    pandoc

# Install R packages
RUN R -e "install.packages(c('stringr','ggplot2','rmarkdown'), repos='https://cloud.r-project.org/')"

WORKDIR /app
COPY . .

# Default: run analysis script and render PDF report
CMD ["bash", "-lc", "bash scripts/run_pokemon_analysis.sh && make report"]
