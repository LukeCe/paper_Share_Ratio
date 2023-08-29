FROM rocker/geospatial:4.3.1

LABEL maintainer "Lukas Dargel <lukece@mailbox.org>"

# Install R packages (latest from CRAN)
RUN install2.r --error --skipinstalled --ncpus -1 \
    archive \
    colorspace \
    compositions \
    data.table \
    ggplot2 \
    here \
    kableExtra \
    quarto \
    remotes \
    zCompositions

# Install:
# - specific versions of R packages (h2o must be syncronised with the version of the h2o image)
# - additional LaTeX packages (for compiling rmarkdown)
RUN R -e 'remotes::install_github("LukeCe/CoDaImpact", type="source")'
EXPOSE 8787
