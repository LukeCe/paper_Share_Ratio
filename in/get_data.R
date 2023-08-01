message("Collecting data for presidential election.")

# cran
library("archive")
library("data.table")
library("here")
library("stringr")
library("sf")


# local
source(here("R/utils_messages.R"))

# dir
dir.create(here("in/data"),showWarnings = FALSE, recursive = TRUE)

# options
oop <- options(timeout = 1000)


# ---- Election data a municipality level -------------------------------------
sec___________________________________________________________________________(
  "Election data on municipality level")

msg <- "Get data from stable url: "
mun_elec <- "https://www.data.gouv.fr/fr/datasets/r/aae19572-df6d-4e05-ab09-06430ca8acde"
message(msg, mun_elec)
suppressWarnings({
mun_elec <- fread(mun_elec, sep = ";",encoding = 'Latin-1',check.names = FALSE)
})


subsec________________________________________________________________________(
  "Start cleaning the columns.")

message("Create an id for each municipality: ID_MUN")
ID_MUN <- paste0(
  mun_elec[[1]],
  str_pad(string = mun_elec[[3]],width = 3,side = "left",pad = "0"))

stopifnot(length(unique(ID_MUN)) == nrow(mun_elec))


message("Convert votes into a matrix")
VOTES_NAMES <- c(
  ABSTENTIONS = "Abstentions",
  BLANK = "Blancs",
  INVALID = "Nuls",
  ARTHAUD_Nathalie = "Voix",
  ROUSSEL_Fabien = "V31",
  MACRON_Emmanuel = "V38",
  LASSALLE_Jean = "V45",
  LE_PEN_Marine = "V52",
  ZEMMOUR_Eric = "V59",
  MELENCHON_Jean_Luc = "V66",
  HIDALGO_Anne = "V73",
  JADOT_Yannick = "V80",
  PECRESSE_Valerie = "V87",
  POUTOU_Philippe = "V94",
  DUPONT_AIGNAN_Nicolas = "V101")

VOTES <- mun_elec[,..VOTES_NAMES]
colnames(VOTES) <- names(VOTES_NAMES)
stopifnot(all(rowSums(VOTES) == mun_elec$Inscrits))
mun_elec <- data.table(
  ID_MUN,
  NAME_MUN = mun_elec[["Libellé de la commune"]],
  NAME_DEP = mun_elec[["Libellé du département"]],
  VOTES)

message("Finished vote data preparations.")
message_df(head(mun_elec,2))
message("Wrting results to disc...")
saveRDS(mun_elec, here("in/data/mun_elec.Rds"))

# ---- French population census on municipality level -------------------------
sec___________________________________________________________________________(
  "French population census on municipality level")



subsec________________________________________________________________________(
  "Start with data on professional categories"
)

msg <- "Download zip archive from url: "
iris_profcat <- "https://www.insee.fr/fr/statistiques/fichier/6543200/base-ic-evol-struct-pop-2019_csv.zip"
message(msg, iris_profcat)
message("For documentation see: https://www.insee.fr/fr/statistiques/6543200#consulter")
download.file(iris_profcat, "tmp.zip")


message("Read to memroy and remove download.")
iris_profcat <- fread(cmd = "unzip -p  tmp.zip base-ic-evol-struct-pop-2019.CSV")
unlink("tmp.zip")


msg <- "Select columns for socioprofessional categories"
keep_cols <- c(
  "C19_POP15P_CS1",
  "C19_POP15P_CS2",
  "C19_POP15P_CS3",
  "C19_POP15P_CS4",
  "C19_POP15P_CS5",
  "C19_POP15P_CS6",
  "C19_POP15P_CS7",
  "C19_POP15P_CS8")
message(msg, msglist(keep_cols))


message("Aggregate data on commune level.")
mun_profcat <- iris_profcat[,lapply(.SD, sum),.SDcols = keep_cols, by = "COM"]
setnames(mun_profcat, "COM", "ID_MUN")
message("Finished census data preparations.")
message_df(head(mun_profcat,2))

message("Wrting results to disc...")
saveRDS(mun_profcat, here("in/data/mun_profcat.Rds"))


sec___________________________________________________________________________(
  "Spatial polygons of municipalities.")
mun_geo <- "https://wxs.ign.fr/x02uy2aiwjo9bm8ce5plwqmr/telechargement/prepackage/ADMINEXPRESS-COG_SHP_TERRITOIRES_PACK_2021-05-19$ADMIN-EXPRESS-COG_3-0__SHP_LAMB93_FXX_2021-05-19/file/ADMIN-EXPRESS-COG_3-0__SHP_LAMB93_FXX_2021-05-19.7z"
download.file(mun_geo,destfile = "mun_geo.7z")
archive_extract("mun_geo.7z")
mun_geo <- read_sf("ADMIN-EXPRESS-COG_3-0__SHP_LAMB93_FXX_2021-05-19/ADMIN-EXPRESS-COG/1_DONNEES_LIVRAISON_2021-05-19/ADECOG_3-0_SHP_LAMB93_FXX/COMMUNE.shp")
unlink("mun_geo.7z")
unlink("ADMIN-EXPRESS-COG_3-0__SHP_LAMB93_FXX_2021-05-19", recursive = TRUE)


message("Wrting results to disc...")
saveRDS(mun_geo, here("in/data/mun_geo.Rds"))
options(oop)
