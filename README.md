
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Pairwise share-ratio interpretations of compositional regression models

This repository contains all codes necessary to reproduce the results of
our article *“Pairwise share-ratio interpretations of compositional
regression models”*, that is currently available as a working paper:

> Dargel, Lukas, and Christine Thomas-Agnan (2023). *Pairwise
> share-ratio interpretations of compositional regression models*. TSE
> Working Paper, n. 23-1456, July 2023., Accessed 29 Aug 2023. Online at
> <https://www.tse-fr.eu/sites/default/files/TSE/documents/doc/wp/2023/wp_tse_1456.pdf>

The vignette accompanying the article illustrates the presented
mathematical tools for a French electoral sociology case study and can
be [downloaded directly as
HTML](https://github.com/LukeCe/paper_Share_Ratio/blob/master/notebooks/Modeling%20the%20French%20presidential%20elections%20of%202022%20with%20CoDa%20tools.html).

## Notes on reproducibility

To reproduce the results, clone this repository and then build or
download the associated docker image. From within the docker image, all
steps of the analysis are relaunched using the `dvc repro` command.

``` sh
# get all codes from GitHub
git clone https://github.com/LukeCe/paper_Share_Ratio
cd paper_Share_Ratio

# download the docker image that contains most dependencies
docker pull lukece/rdevkit:2023.02

# run the analysis from within the docker image
docker run rdevkit:2023.02 Rscript repro.R
```

Executing the command `Rscript repro.R` performs the following four
steps:

1.  Install missing libraries from CRAN or GitHub

2.  Download the three source data sets and place them in `in\data`:

    - Election results [from the French Ministry of the
      Interior](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-10-et-24-avril-2022-resultats-definitifs-du-1er-tour/#/resources)
    - Socio-demographic information from the population census [provided
      by INSEE](https://www.insee.fr/fr/statistiques/6543200)
    - Geographic contours of French municipalities [provided by
      IGN](https://geoservices.ign.fr/adminexpress) (this file has about
      250MB and can take some tme to dowload)

3.  Merge the data sources and place the combined data in `out/data`

4.  Rebuild the HTML vignette that generates all results used in the
    article

    - The vignette is placed in `notebooks`
    - The outputs used for the article are placed in `out/figures` and
      `out/tables`

### How to cite

Please cite the above article when using any material from this
repository.

### Licenses

**Text and figures :**
[cc-by-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)

**Data :** See the policies of the original data providers
