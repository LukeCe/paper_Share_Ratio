# cran
library("here")
library("data.table")

# local
source(here("R/utils_messages.R"))

# data
mun_elec <- readRDS("in/data/mun_elec.Rds")
mun_profcat <- readRDS("in/data/mun_profcat.Rds")

# ---- ID_MUNbine data sources ---------------------------------------------------
sec___________________________________________________________________________(
  "Combine election and cesus data.")
stopifnot(all(complete.cases(mun_profcat)))
stopifnot(all(complete.cases(mun_elec)))


subsec________________________________________________________________________(
  "Treat Marseille, Lyon and Paris.")

message("The large cities are devided in arrondissements in the census,\n",
        "but not in the election data.",
        "We need to aggregate them to the same level.")

marseille_mun <- "13055"
marseille_arr <- as.character(c(
  13201, 13202, 13203, 13204, 13205,
  13206, 13207, 13208, 13209, 13210,
  13211, 13212, 13213, 13214, 13215,
  13216))

lyon_mun <- "69123"
lyon_arr <- as.character(c(
  69381, 69382, 69383, 69384, 69385,
  69386, 69387, 69388, 69389))

paris_mun <- "75056"
paris_arr <- as.character(c(
  75101, 75102, 75103, 75104, 75105,
  75106, 75107, 75108, 75109, 75110,
  75111, 75112, 75113, 75114, 75115,
  75116, 75117, 75118, 75119, 75120))

mun_profcat[ID_MUN %in% marseille_arr, ID_MUN := marseille_mun]
mun_profcat[ID_MUN %in% lyon_arr, ID_MUN := lyon_mun]
mun_profcat[ID_MUN %in% paris_arr, ID_MUN := paris_mun]
mun_profcat <- mun_profcat[,lapply(.SD, sum), by = "ID_MUN"]


subsec________________________________________________________________________(
  "Remove overseas departments from election data.")

mun_elec <- mun_elec[NAME_DEP != "Français établis hors de France",]
mun_elec <- mun_elec[!grepl(pattern = "^[a-zA-Z].*",ID_MUN),]
mun_elec2census <- merge(mun_elec, mun_profcat, by.x = "ID_MUN", by.y = "ID_MUN")
stopifnot(all(complete.cases(mun_elec2census)),
          nrow(mun_elec2census) == nrow(mun_elec))

message("Successfully combined census and election data.\n",
        "Writing results to file out/data/mun_elec2census.Rds")
saveRDS(mun_elec2census, here("out/data/mun_elec2census.Rds"))


