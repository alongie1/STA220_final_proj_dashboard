# scripts/01_import.R
# Reads two sources from the files in data/ and writes one clean CSV for each.
#
#   Source 1: U.S. Census Bureau, American Community Survey 2020-2024 (5-year), table B25064, Median
#             Gross Rent, for New Jersey and every New Jersey town (county subdivision). Downloaded
#             from data.census.gov on October 28, 2026.
#             In:  data/ACSDT5Y2024.B25064-Data.csv (from the download's zip, unchanged)
#             Out: data/rent_clean.csv, one row per town
#                  data/rent_clean_nj.csv, one row: New Jersey
#
#   Source 2: NJ Department of Education, School Performance Reports 2024-2025, NJGPA table.
#             In:  data/njdoe_njgpa_all_students.csv (cut by hand from the Department's 119 MB
#                  Excel file, which is too big for GitHub; the README lists every step)
#                  https://www.nj.gov/education/spr/download/ - select district/state performance reports database in excel
#             Out: data/njgpa_clean.csv, one row per school district in 2024-25
#                  data/njgpa_clean_nj.csv, one row: New Jersey (the State row) in 2024-25
#
# NOTE: You do NOT need to learn every command in this script. 3.2b starts AFTER this script:
# it is "done," and 02_merge.R only reads the clean files it writes.
#
# All of these tasks can be done manually.


# Packages ---------------------------------------------------------------------------------------

library(tidyverse)


# Source 1: Rutgers New Jersey Data Book, NJ Municipality Population Data ---------------------------------------------------------------


#munic_data <- read_csv(
# "data/MunicipalData.csv",
#  skip = 2,                                                      # Skips the two header rows
#  col_names = c("county", "municipality", "dlgs", "ld", "cd", "area_2018", "area_2019", "area_2020", "area_2021", "pop_2018", "pop_2019", "pop_2020", "pop_2021"),    # rename the first four columns
#  col_select = 1:13,                                              # Select the first thirteen columns
#  col_types = cols(.default = col_character()),                  # Set default column to character
#  na = c("", "-", "**", "***", "NULL")                                   # turns cells containing blanks, "-", "**", and "***" into NA
#)

# One row is one place: every municipality. Expect 567 rows and 13 columns.
# Expect all variable types are character
#dim(munic_data)
#names(munic_data)
#summary(munic_data)

# Clean geo_id, rent, and rent margin of error
#munic_clean <- munic_data |>
#  mutate(
#    ld = as.numeric(str_remove_all(ld, "[,+]")),
#    cd = as.numeric(str_remove_all(cd, "[,+]")),
#    area_2018 = as.numeric(str_remove_all(area_2018, "[,+]")),
#    area_2019 = as.numeric(str_remove_all(area_2019, "[,+]")),
#    area_2020 = as.numeric(str_remove_all(area_2020, "[,+]")),
#    area_2021 = as.numeric(str_remove_all(area_2021, "[,+]")),
#    pop_2018 = as.numeric(str_remove_all(pop_2018, "[,+]")),
#    pop_2019 = as.numeric(str_remove_all(pop_2019, "[,+]")),
#    pop_2020 = as.numeric(str_remove_all(pop_2020, "[,+]")),
#    pop_2021 = as.numeric(str_remove_all(pop_2021, "[,+]")), # remove all strings from median rent, including the + for top code, and turns numeric
#  )

# One row is one town (expect 564). 5 variables (top coded is new!)
#dim(munic_clean)
#names(munic_clean)
#summary(munic_clean)

# the key check: 0 rows means dlgs is a key
#munic_clean |>
#  count(dlgs) |>
#  filter(n > 1)


# Source 2: NJ DOE, NJGPA ------------------------------------------------------------------------

munic_data <- read_csv(
  "data/MunicipalData.csv",
  skip = 2,                                                      # Skips the two header rows
  col_names = c("county", "municipality", "dlgs", "ld", "cd", "area_2018", "area_2019", "area_2020", "area_2021", 
                "pop_2018", "pop_2019", "pop_2020", "pop_2021", "over_age_25_2018",	"over_age_25_2019",	"over_age_25_2020",	"over_age_25_2021",	
                "col_grad_2018",	"col_grad_2019",	"col_grad_2020",	"col_grad_2021",	
                "perc_col_grad_2018",	"perc_col_grad_2019",	"perc_col_grad_2020",	"perc_col_grad_2021",	
                "foreign_born_2018",	"foreign_born_2019",	"foreign_born_2020",	"foreign_born_2021",	
                "perc_foreign_born_2018",	"perc_foreign_born_2019",	"perc_foreign_born_2020",	"perc_foreign_born_2021",	
                "afr_american_2018", "afr_american_2019", "afr_american_2020", "afr_american_2021", 
                "perc_afr_american_2018", "perc_afr_american_2019", "perc_afr_american_2020", "perc_afr_american_2021", 
                "asian_2018", "asian_2019", "asian_2020", "asian_2021", "perc_asian_2018", "perc_asian_2019", "perc_asian_2020", "perc_asian_2021", 
                "hisp_2018", "hisp_2019", "hisp_2020", "hisp_2021", "perc_hisp_2018", "perc_hisp_2019", "perc_hisp_2020", "perc_hisp_2021", 
                "below_age_5_2018", "below_age_5_2019", "below_age_5_2020", "below_age_5_2021", 
                "over_age_65_2018", "over_age_65_2019", "over_age_65_2020", "over_age_65_2021", 
                "perc_65_or_above_2018", "perc_65_or_above_2019", "perc_65_or_above_2020", "perc_65_or_above_2021", 
                "viol_crime_2018", "viol_crime_2019", "viol_crime_2020", "viol_crime_2021", 
                "non_viol_crime_2018", "non_viol_crime_2019", "non_viol_crime_2020", "non_viol_crime_2021", 
                "workforce_2018", "workforce_2019", "workforce_2020", "workforce_2021", 
                "unemployed_2018",	"unemployed_2019",	"unemployed_2020",	"unemployed_2021",	
                "perc_unemployed_2018",	"perc_unemployed_2019",	"perc_unemployed_2020",	"perc_unemployed_2021",
                "med_rent_2018",	"med_rent_2019",	"med_rent_2020",	"med_rent_2021",	
                "avg_res_prop_value_2018", "avg_res_prop_value_2019", "avg_res_prop_value_2020", "avg_res_prop_value_2021", 
                "income_per_taxpayer_2018", "income_per_taxpayer_2019", "income_per_taxpayer_2020", "income_per_taxpayer_2021", 
                "munic_budg_per_cap_2018",	"munic_budg_per_cap_2019",	"munic_budg_per_cap_2020",	"munic_budg_per_cap_2021",		
                "munic_budg_2018",	"munic_budg_2019",	"munic_budg_2020",	"munic_budg_2021", 
                "prop_tax_as_perc_income_2018",	"prop_tax_as_perc_income_2019",	"prop_tax_as_perc_income_2020",	"prop_tax_as_perc_income_2021",		
                "county_gov_tax_rate_2018",	"county_gov_tax_rate_2019",	"county_gov_tax_rate_2020",	"county_gov_tax_rate_2021",		
                "munic_tax_rate_2018",	"munic_tax_rate_2019",	"munic_tax_rate_2020",	"munic_tax_rate_2021",	
                "school_tax_rate_2018", "school_tax_rate_2019", "school_tax_rate_2020", "school_tax_rate_2021"),    # rename the columns
  col_select = 1:125,                                              # Select the first thirteen columns
  col_types = cols(.default = col_character()),                  # Set default column to character
  na = c("", "-", "**", "***", "NULL")                                   # turns cells containing blanks, "-", "**", and "***" into NA
)

# One row is one place: every municipality. Expect 567 rows and 13 columns.
# Expect all variable types are character
dim(munic_data)
names(munic_data)
summary(munic_data)

# Clean geo_id, rent, and rent margin of error
munic_clean <- munic_data |>
  mutate(
    ld = as.numeric(str_remove_all(ld, "[,+]")),
    cd = as.numeric(str_remove_all(cd, "[,+]")),
    area_2018 = as.numeric(str_remove_all(area_2018, "[,+]")),
    area_2019 = as.numeric(str_remove_all(area_2019, "[,+]")),
    area_2020 = as.numeric(str_remove_all(area_2020, "[,+]")),
    area_2021 = as.numeric(str_remove_all(area_2021, "[,+]")),
    pop_2018 = as.numeric(str_remove_all(pop_2018, "[,+]")),
    pop_2019 = as.numeric(str_remove_all(pop_2019, "[,+]")),
    pop_2020 = as.numeric(str_remove_all(pop_2020, "[,+]")),
    pop_2021 = as.numeric(str_remove_all(pop_2021, "[,+]")), 
    over_age_25_2018 = as.numeric(str_remove_all(over_age_25_2018, "[,+]")), 
    over_age_25_2019	= as.numeric(str_remove_all(over_age_25_2019, "[,+]")),
    over_age_25_2020	= as.numeric(str_remove_all(over_age_25_2020, "[,+]")),
    over_age_25_2021	= as.numeric(str_remove_all(over_age_25_2021, "[,+]")),
    col_grad_2018	= as.numeric(str_remove_all(col_grad_2018, "[,+]")),
    col_grad_2019	= as.numeric(str_remove_all(col_grad_2019, "[,+]")),
    col_grad_2020	= as.numeric(str_remove_all(col_grad_2020, "[,+]")),
    col_grad_2021	= as.numeric(str_remove_all(col_grad_2021, "[,+]")),
    perc_col_grad_2018	= as.numeric(str_remove_all(perc_col_grad_2018, "[,+]")),
    perc_col_grad_2019	= as.numeric(str_remove_all(perc_col_grad_2019, "[,+]")),
    perc_col_grad_2020	= as.numeric(str_remove_all(perc_col_grad_2020, "[,+]")),
    perc_col_grad_2021	= as.numeric(str_remove_all(perc_col_grad_2021, "[,+]")),
    foreign_born_2018	= as.numeric(str_remove_all(foreign_born_2018, "[,+]")),
    foreign_born_2019	= as.numeric(str_remove_all(foreign_born_2019, "[,+]")),
    foreign_born_2020	= as.numeric(str_remove_all(foreign_born_2020, "[,+]")),
    foreign_born_2021	= as.numeric(str_remove_all(foreign_born_2021, "[,+]")),
    perc_foreign_born_2018	= as.numeric(str_remove_all(perc_foreign_born_2018, "[,+]")),
    perc_foreign_born_2019	= as.numeric(str_remove_all(perc_foreign_born_2019, "[,+]")),
    perc_foreign_born_2020	= as.numeric(str_remove_all(perc_foreign_born_2020, "[,+]")),
    perc_foreign_born_2021	= as.numeric(str_remove_all(perc_foreign_born_2021, "[,+]")),
    afr_american_2018 = as.numeric(str_remove_all(afr_american_2018, "[,+]")),
    afr_american_2019 = as.numeric(str_remove_all(afr_american_2019, "[,+]")),
    afr_american_2020 = as.numeric(str_remove_all(afr_american_2020, "[,+]")),
    afr_american_2021 = as.numeric(str_remove_all(afr_american_2021, "[,+]")),
    perc_afr_american_2018 = as.numeric(str_remove_all(perc_afr_american_2018, "[,+]")),
    perc_afr_american_2019 = as.numeric(str_remove_all(perc_afr_american_2019, "[,+]")),
    perc_afr_american_2020 = as.numeric(str_remove_all(perc_afr_american_2020, "[,+]")),
    perc_afr_american_2021 = as.numeric(str_remove_all(perc_afr_american_2021, "[,+]")),
    asian_2018 = as.numeric(str_remove_all(asian_2018, "[,+]")),
    asian_2019 = as.numeric(str_remove_all(asian_2019, "[,+]")),
    asian_2020 = as.numeric(str_remove_all(asian_2020, "[,+]")),
    asian_2021 = as.numeric(str_remove_all(asian_2021, "[,+]")),
    perc_asian_2018 = as.numeric(str_remove_all(perc_asian_2018, "[,+]")),
    perc_asian_2019 = as.numeric(str_remove_all(perc_asian_2019, "[,+]")),
    perc_asian_2020 = as.numeric(str_remove_all(perc_asian_2020, "[,+]")),
    perc_asian_2021 = as.numeric(str_remove_all(perc_asian_2021, "[,+]")),
    hisp_2018 = as.numeric(str_remove_all(hisp_2018, "[,+]")),
    hisp_2019 = as.numeric(str_remove_all(hisp_2019, "[,+]")),
    hisp_2020 = as.numeric(str_remove_all(hisp_2020, "[,+]")),
    hisp_2021 = as.numeric(str_remove_all(hisp_2021, "[,+]")),
    perc_hisp_2018 = as.numeric(str_remove_all(perc_hisp_2018, "[,+]")),
    perc_hisp_2019 = as.numeric(str_remove_all(perc_hisp_2019, "[,+]")),
    perc_hisp_2020 = as.numeric(str_remove_all(perc_hisp_2020, "[,+]")),
    perc_hisp_2021 = as.numeric(str_remove_all(perc_hisp_2021, "[,+]")),
    below_age_5_2018 = as.numeric(str_remove_all(below_age_5_2018, "[,+]")),
    below_age_5_2019 = as.numeric(str_remove_all(below_age_5_2019, "[,+]")),
    below_age_5_2020 = as.numeric(str_remove_all(below_age_5_2020, "[,+]")),
    below_age_5_2021 = as.numeric(str_remove_all(below_age_5_2021, "[,+]")),
    over_age_65_2018 = as.numeric(str_remove_all(over_age_65_2018, "[,+]")),
    over_age_65_2019 = as.numeric(str_remove_all(over_age_65_2019, "[,+]")),
    over_age_65_2020 = as.numeric(str_remove_all(over_age_65_2020, "[,+]")),
    over_age_65_2021 = as.numeric(str_remove_all(over_age_65_2021, "[,+]")),
    perc_65_or_above_2018 = as.numeric(str_remove_all(perc_65_or_above_2018, "[,+]")),
    perc_65_or_above_2019 = as.numeric(str_remove_all(perc_65_or_above_2019, "[,+]")),
    perc_65_or_above_2020 = as.numeric(str_remove_all(perc_65_or_above_2020, "[,+]")),
    perc_65_or_above_2021 = as.numeric(str_remove_all(perc_65_or_above_2021, "[,+]")),
    viol_crime_2018 = as.numeric(str_remove_all(viol_crime_2018, "[,+]")),
    viol_crime_2019 = as.numeric(str_remove_all(viol_crime_2019, "[,+]")),
    viol_crime_2020 = as.numeric(str_remove_all(viol_crime_2020, "[,+]")),
    viol_crime_2021 = as.numeric(str_remove_all(viol_crime_2021, "[,+]")),
    non_viol_crime_2018 = as.numeric(str_remove_all(non_viol_crime_2018, "[,+]")),
    non_viol_crime_2019 = as.numeric(str_remove_all(non_viol_crime_2019, "[,+]")),
    non_viol_crime_2020 = as.numeric(str_remove_all(non_viol_crime_2020, "[,+]")),
    non_viol_crime_2021 = as.numeric(str_remove_all(non_viol_crime_2021, "[,+]")),
    workforce_2018 = as.numeric(str_remove_all(workforce_2018, "[,+]")),
    workforce_2019 = as.numeric(str_remove_all(workforce_2019, "[,+]")),
    workforce_2020 = as.numeric(str_remove_all(workforce_2020, "[,+]")),
    workforce_2021 = as.numeric(str_remove_all(workforce_2021, "[,+]")),
    unemployed_2018	= as.numeric(str_remove_all(unemployed_2018, "[,+]")),
    unemployed_2019	= as.numeric(str_remove_all(unemployed_2019, "[,+]")),
    unemployed_2020	= as.numeric(str_remove_all(unemployed_2020, "[,+]")),
    unemployed_2021	= as.numeric(str_remove_all(unemployed_2021, "[,+]")),
    perc_unemployed_2018 = as.numeric(str_remove_all(perc_unemployed_2018, "[,+]")),
    perc_unemployed_2019 = as.numeric(str_remove_all(perc_unemployed_2019, "[,+]")),
    perc_unemployed_2020 = as.numeric(str_remove_all(perc_unemployed_2020, "[,+]")),
    perc_unemployed_2021 = as.numeric(str_remove_all(perc_unemployed_2021, "[,+]")),
    med_rent_2018	= as.numeric(str_remove_all(med_rent_2018, "[,+]")),
    med_rent_2019	= as.numeric(str_remove_all(med_rent_2019, "[,+]")),
    med_rent_2020	= as.numeric(str_remove_all(med_rent_2020, "[,+]")),
    med_rent_2021	= as.numeric(str_remove_all(med_rent_2021, "[,+]")),
    avg_res_prop_value_2018 = as.numeric(str_remove_all(avg_res_prop_value_2018, "[,+]")),
    avg_res_prop_value_2019 = as.numeric(str_remove_all(avg_res_prop_value_2019, "[,+]")),
    avg_res_prop_value_2020 = as.numeric(str_remove_all(avg_res_prop_value_2020, "[,+]")),
    avg_res_prop_value_2021 = as.numeric(str_remove_all(avg_res_prop_value_2021, "[,+]")),
    income_per_taxpayer_2018 = as.numeric(str_remove_all(income_per_taxpayer_2018, "[,+]")),
    income_per_taxpayer_2019 = as.numeric(str_remove_all(income_per_taxpayer_2019, "[,+]")),
    income_per_taxpayer_2020 = as.numeric(str_remove_all(income_per_taxpayer_2020, "[,+]")),
    income_per_taxpayer_2021 = as.numeric(str_remove_all(income_per_taxpayer_2021, "[,+]")),
    munic_budg_per_cap_2018	= as.numeric(str_remove_all(munic_budg_per_cap_2018, "[,+]")),
    munic_budg_per_cap_2019	= as.numeric(str_remove_all(munic_budg_per_cap_2019, "[,+]")),
    munic_budg_per_cap_2020	= as.numeric(str_remove_all(munic_budg_per_cap_2020, "[,+]")),
    munic_budg_per_cap_2021 = as.numeric(str_remove_all(munic_budg_per_cap_2021, "[,+]")),
    munic_budg_2018	= as.numeric(str_remove_all(munic_budg_2018, "[,+]")),
    munic_budg_2019	= as.numeric(str_remove_all(munic_budg_2019, "[,+]")),
    munic_budg_2020	= as.numeric(str_remove_all(munic_budg_2020, "[,+]")),
    munic_budg_2021 = as.numeric(str_remove_all(munic_budg_2021, "[,+]")),
    prop_tax_as_perc_income_2018	= as.numeric(str_remove_all(prop_tax_as_perc_income_2018, "[,+]")),
    prop_tax_as_perc_income_2019	= as.numeric(str_remove_all(prop_tax_as_perc_income_2019, "[,+]")),
    prop_tax_as_perc_income_2020	= as.numeric(str_remove_all(prop_tax_as_perc_income_2020, "[,+]")),
    prop_tax_as_perc_income_2021	= as.numeric(str_remove_all(prop_tax_as_perc_income_2021, "[,+]")),
    county_gov_tax_rate_2018	= as.numeric(str_remove_all(county_gov_tax_rate_2018, "[,+]")),
    county_gov_tax_rate_2019	= as.numeric(str_remove_all(county_gov_tax_rate_2019, "[,+]")),
    county_gov_tax_rate_2020	= as.numeric(str_remove_all(county_gov_tax_rate_2020, "[,+]")),
    county_gov_tax_rate_2021	= as.numeric(str_remove_all(county_gov_tax_rate_2021, "[,+]")),
    munic_tax_rate_2018	= as.numeric(str_remove_all(munic_tax_rate_2018, "[,+]")),
    munic_tax_rate_2019	= as.numeric(str_remove_all(munic_tax_rate_2019, "[,+]")),
    munic_tax_rate_2020	= as.numeric(str_remove_all(munic_tax_rate_2020, "[,+]")),
    munic_tax_rate_2021	= as.numeric(str_remove_all(munic_tax_rate_2021, "[,+]")),
    school_tax_rate_2018 = as.numeric(str_remove_all(school_tax_rate_2018, "[,+]")),
    school_tax_rate_2019 = as.numeric(str_remove_all(school_tax_rate_2019, "[,+]")),
    school_tax_rate_2020 = as.numeric(str_remove_all(school_tax_rate_2020, "[,+]")),
    school_tax_rate_2021 = as.numeric(str_remove_all(school_tax_rate_2021, "[,+]")), # remove all strings from variables, and turns numeric
  )

# One row is one town (expect 564). 5 variables (top coded is new!)
dim(munic_clean)
names(munic_clean)
summary(munic_clean)

# the key check: 0 rows means dlgs is a key
munic_clean |>
  count(dlgs) |>
  filter(n > 1)

#njgpa_raw <- read_csv(
#  "data/njgpa_district_2024_allstudent.csv",
#  col_types = cols(.default = col_character())                   # every column as text (keeps leading zeros and percents)
#)

# New Jersey (the "State" row) shouldn't be here
#njgpa_raw_nj <- filter(njgpa_raw, DistrictCode == "State")

#njgpa_raw <- filter(njgpa_raw, DistrictCode != "State")

# One row is one district in one school year, all students. Expect 960 rows (320 x 3 school years)
# and 14 columns. Expect all variable types are character
#dim(njgpa_raw)
#names(njgpa_raw)
#summary(njgpa_raw)

# New Jersey is intact: expect 3 rows (one per school year) and 14 columns
# all variables should be characters
#dim(njgpa_raw_nj)
#names(njgpa_raw_nj)
#summary(njgpa_raw_nj)


# Clean district code, names, and the percent graduation ready
#njgpa_clean <- njgpa_raw |>
  #filter(SchoolYear == "2024-25") |>                                                  # keep only 2024-25
  #mutate(
    #math_ready = as.numeric(str_remove(MathGraduationReadyPct_District, "%")),       # remove the % and turn numeric 
    #ela_ready = as.numeric(str_remove(ELAGraduationReadyPct_District, "%"))
  #) |>
  #select(
    #district_code = DistrictCode,                                                     # rename while selecting
    #district = DistrictName,
    #district_county = CountyName,
    #math_ready,
    #ela_ready
  #)

# Clean for nj (its percents are in the _State columns, not the _District columns)
#njgpa_clean_nj <- njgpa_raw_nj |>
  #filter(SchoolYear == "2024-25") |>
  #mutate(
    #math_ready = as.numeric(str_remove(MathGraduationReadyPct_State, "%")),
    #ela_ready = as.numeric(str_remove(ELAGraduationReadyPct_State, "%"))
  #) |>
  #select(
    #district_code = DistrictCode,
    #district = DistrictName,
    #math_ready,
    #ela_ready
  #)

# One row is one district in 2024-25 (expect 320). 5 variables, and no NA in math_ready or ela_ready
#dim(njgpa_clean)
#names(njgpa_clean)
#summary(njgpa_clean)

# expect 1 row and 4 columns: 58.5 percent graduation ready in math, 81.3 in ELA
#dim(njgpa_clean_nj)
#names(njgpa_clean_nj)
#summary(njgpa_clean_nj)

# the key check: 0 rows means district_code is a key
#njgpa_clean |>
  #count(district_code) |>
  #filter(n > 1)


# Save -------------------------------------------------------------------------------------------

write_csv(munic_clean, "data/munic_clean.csv")

#write_csv(rent_clean_nj, "data/rent_clean_nj.csv")

#write_csv(njgpa_clean, "data/njgpa_clean.csv")

#write_csv(njgpa_clean_nj, "data/njgpa_clean_nj.csv")
