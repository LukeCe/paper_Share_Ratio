
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Pairwise share ratio interpretations of compositional regression models

This repository contains all codes necessary to reproduce the results of
our article *“Pairwise share ratio interpretations of compositional
regression models”*, available at:

> Dargel, Lukas, and Christine Thomas-Agnan (2024). *Pairwise share
> ratio interpretations of compositional regression models*.
> Computational Statistics & Data Analysis, Volume 195, July 2024,
> 107945 Accessed 08 Mar 2024. Online at
> <https://doi.org/10.1016/j.csda.2024.107945>

The vignette accompanying the article illustrates the presented
mathematical tools for a case study of French electoral sociology and
can be [downloaded directly as
HTML](https://htmlpreview.github.io/?https://github.com/LukeCe/paper_Share_Ratio/blob/master/notebooks/Modeling%20the%20French%20presidential%20elections%20of%202022%20with%20CoDa%20tools.html).

## Notes on reproducibility

To reproduce the results, you can run the bash commands below:

``` bash
# get all codes from GitHub
git clone https://github.com/LukeCe/paper_Share_Ratio
cd paper_Share_Ratio # change working directory to the cloned git

# build the docker image for the paper from the current directory
docker build -t repro_share_ratio . 

# run the analysis from within the docker container
docker run --rm \
  -v .:/home/paper_Share_Ratio \  # mount the repository into the docker
  -w '/home/paper_Share_Ratio' \  # change working directory accordingly
  repro_share_ratio \             # specfiy the docker image
  Rscript repro.R                 # execute the repro.R script
```

Executing the command `Rscript repro.R` performs the following steps:

1.  Download the three source data sets and places them in `in\data`:

    - Election results [from the French Ministry of the
      Interior](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-10-et-24-avril-2022-resultats-definitifs-du-1er-tour/#/resources)
    - Socio-demographic information from the population census [provided
      by INSEE](https://www.insee.fr/fr/statistiques/6543200)
    - Geographic contours of French municipalities [provided by
      IGN](https://geoservices.ign.fr/adminexpress) (this file has about
      250MB and can take some time to download)

2.  Merge the data sources and place the combined data in `out/data`

3.  Rebuild the HTML vignette that generates all results used in the
    article

    - The vignette is placed in `notebooks`
    - The outputs used for the article are placed in `out/figures` and
      `out/tables`

### How to cite

Please cite the above article when using any material from this
repository.

### Licenses

**Text and figures :** [CC BY
4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)

**Data :** See the policies of the original data providers
