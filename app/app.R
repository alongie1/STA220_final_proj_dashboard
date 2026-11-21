# app.R
# A base dashboard to edit for your final project. See "Using the Dashboard Template."
# Based on "Hello Shiny!" https://shiny.posit.co/r/gallery/start-simple/faithful/

library(shiny)
library(tidyverse)


# The Data ---------------------------------------------------------------------------------------

# Save your cleaned data in app/data/, then delete the # below.
# Yes, you will have cleaned data in two places in your repo.
munic_clean <- read_csv(
  "data/munic_clean.csv",
  col_types = cols(
    county = col_character(),
    municipality = col_character(),
    dlgs = col_double(),
    ld = col_double(),
    cd = col_double(),
    area_2018 = col_double(),
    area_2019 = col_double(),
    area_2020 = col_double(),
    area_2021 = col_double(),
    pop_2018 = col_double(),
    pop_2019 = col_double(),
    pop_2020 = col_double(),
    pop_2021 = col_double(),
    over_age_25_2018 = col_double(),
    over_age_25_2019 = col_double(),
    over_age_25_2020 = col_double(),
    over_age_25_2021 = col_double(),
    col_grad_2018 = col_double(),
    col_grad_2019 = col_double(),
    col_grad_2020 = col_double(),
    col_grad_2021 = col_double(),
    perc_col_grad_2018 = col_double(),
    perc_col_grad_2019 = col_double(),
    perc_col_grad_2020 = col_double(),
    perc_col_grad_2021 = col_double(),
    foreign_born_2018 = col_double(),
    foreign_born_2019 = col_double(),
    foreign_born_2020 = col_double(),
    foreign_born_2021 = col_double(),
    perc_foreign_born_2018 = col_double(),
    perc_foreign_born_2019 = col_double(),
    perc_foreign_born_2020 = col_double(),
    perc_foreign_born_2021 = col_double(),
    afr_american_2018 = col_double(),
    afr_american_2019 = col_double(),
    afr_american_2020 = col_double(),
    afr_american_2021 = col_double(),
    perc_afr_american_2018 = col_double(),
    perc_afr_american_2019 = col_double(),
    perc_afr_american_2020 = col_double(),
    perc_afr_american_2021 = col_double(),
    asian_2018 = col_double(),
    asian_2019 = col_double(),
    asian_2020 = col_double(),
    asian_2021 = col_double(),
    perc_asian_2018 = col_double(),
    perc_asian_2019 = col_double(),
    perc_asian_2020 = col_double(),
    perc_asian_2021 = col_double(),
    hisp_2018 = col_double(),
    hisp_2019 = col_double(),
    hisp_2020 = col_double(),
    hisp_2021 = col_double(),
    perc_hisp_2018 = col_double(),
    perc_hisp_2019 = col_double(),
    perc_hisp_2020 = col_double(),
    perc_hisp_2021 = col_double(),
    below_age_5_2018 = col_double(),
    below_age_5_2019 = col_double(),
    below_age_5_2020 = col_double(),
    below_age_5_2021 = col_double(),
    over_age_65_2018 = col_double(),
    over_age_65_2019 = col_double(),
    over_age_65_2020 = col_double(),
    over_age_65_2021 = col_double(),
    perc_65_or_above_2018 = col_double(),
    perc_65_or_above_2019 = col_double(),
    perc_65_or_above_2020 = col_double(),
    perc_65_or_above_2021 = col_double(),
    viol_crime_2018 = col_double(),
    viol_crime_2019 = col_double(),
    viol_crime_2020 = col_double(),
    viol_crime_2021 = col_double(),
    non_viol_crime_2018 = col_double(),
    non_viol_crime_2019 = col_double(),
    non_viol_crime_2020 = col_double(),
    non_viol_crime_2021 = col_double(),
    workforce_2018 = col_double(),
    workforce_2019 = col_double(),
    workforce_2020 = col_double(),
    workforce_2021 = col_double(),
    unemployed_2018	= col_double(),
    unemployed_2019	= col_double(),
    unemployed_2020	= col_double(),
    unemployed_2021	= col_double(),
    perc_unemployed_2018 = col_double(),
    perc_unemployed_2019 = col_double(),
    perc_unemployed_2020 = col_double(),
    perc_unemployed_2021 = col_double(),
    med_rent_2018	= col_double(),
    med_rent_2019	= col_double(),
    med_rent_2020	= col_double(),
    med_rent_2021	= col_double(),
    avg_res_prop_value_2018 = col_double(),
    avg_res_prop_value_2019 = col_double(),
    avg_res_prop_value_2020 = col_double(),
    avg_res_prop_value_2021 = col_double(),
    income_per_taxpayer_2018 = col_double(),
    income_per_taxpayer_2019 = col_double(),
    income_per_taxpayer_2020 = col_double(),
    income_per_taxpayer_2021 = col_double(),
    munic_budg_per_cap_2018 = col_double(),
    munic_budg_per_cap_2019 = col_double(),
    munic_budg_per_cap_2020 = col_double(),
    munic_budg_per_cap_2021 = col_double(),
    munic_budg_2018 = col_double(),
    munic_budg_2019 = col_double(),
    munic_budg_2020 = col_double(),
    munic_budg_2021 = col_double(),
    prop_tax_as_perc_income_2018 = col_double(),
    prop_tax_as_perc_income_2019 = col_double(),
    prop_tax_as_perc_income_2020 = col_double(),
    prop_tax_as_perc_income_2021 = col_double(),
    county_gov_tax_rate_2018 = col_double(),
    county_gov_tax_rate_2019 = col_double(),
    county_gov_tax_rate_2020 = col_double(),
    county_gov_tax_rate_2021 = col_double(),
    munic_tax_rate_2018 = col_double(),
    munic_tax_rate_2019 = col_double(),
    munic_tax_rate_2020 = col_double(),
    munic_tax_rate_2021 = col_double(),
    school_tax_rate_2018 = col_double(),
    school_tax_rate_2019 = col_double(),
    school_tax_rate_2020 = col_double(),
    school_tax_rate_2021 = col_double()
  )
)
munic_clean_plus <- munic_clean |>
  mutate(
    violent_crime_per_pop_2018 = viol_crime_2018/pop_2018*1000,
    violent_crime_per_pop_2019 = viol_crime_2019/pop_2019*1000,
    violent_crime_per_pop_2020 = viol_crime_2020/pop_2020*1000,
    pop_density_2018 = pop_2018/area_2018,
    pop_density_2019 = pop_2018/area_2019,
    pop_density_2020 = pop_2018/area_2020,
    pop_density_2021 = pop_2018/area_2021
  )

#math_predictions

# Giving towns a label ------------------------------------------------------------

# Label to 2 biggest overperformers, 2 biggest underperformers, and the best-predicted town. 
#labeled <- towns_merged |>
#  filter(town %in% c("Ewing township", "Burlington township", "Plainsboro township", "Trenton city", "Princeton", "Hamilton township", "East Windsor township")) |>
#  mutate(short = str_remove(town, " township| city"))
viol_crime_per_pop <- munic_clean_plus |>
  select(county, violent_crime_per_pop_2018, violent_crime_per_pop_2019, violent_crime_per_pop_2020) |>
  arrange(violent_crime_per_pop_2018) |>
  pivot_longer(-county, names_to = "measure", values_to = "value")

pop_density <- munic_clean_plus |>
  select(county, pop_density_2018, pop_density_2019, pop_density_2020, pop_density_2021) |>
  arrange(pop_density_2018) |>
  pivot_longer(-county, names_to = "measure", values_to = "value")

warren_v <- viol_crime_per_pop |>
  filter(county == "Warren")
union_v <- viol_crime_per_pop |>
  filter(county == "Union")
sussex_v <- viol_crime_per_pop |>
  filter(county == "Sussex")
somerset_v <- viol_crime_per_pop |>
  filter(county == "Somerset")
salem_v <- viol_crime_per_pop |>
  filter(county == "Salem")
passaic_v <- viol_crime_per_pop |>
  filter(county == "Passaic")
ocean_v <- viol_crime_per_pop |>
  filter(county == "Ocean")
morris_v <- viol_crime_per_pop |>
  filter(county == "Morris")
monmouth_v <- viol_crime_per_pop |>
  filter(county == "Monmouth")
middlesex_v <- viol_crime_per_pop |>
  filter(county == "Middlesex")
mercer_v <- viol_crime_per_pop |>
  filter(county == "Mercer")
hunterdon_v <- viol_crime_per_pop |>
  filter(county == "Hunterdon")
hudson_v <- viol_crime_per_pop |>
  filter(county == "Hudson")
gloucester_v <- viol_crime_per_pop |>
  filter(county == "Gloucester")
essex_v <- viol_crime_per_pop |>
  filter(county == "Essex")
cumberland_v <- viol_crime_per_pop |>
  filter(county == "Cumberland")
cape_may_v <- viol_crime_per_pop |>
  filter(county == "Cape May")
camden_v <- viol_crime_per_pop |>
  filter(county == "Camden")
burlington_v <- viol_crime_per_pop |>
  filter(county == "Burlington")
bergen_v <- viol_crime_per_pop |>
  filter(county == "Bergen")
atlantic_v <- viol_crime_per_pop |>
  filter(county == "Atlantic")

warren_p <- pop_density |>
  filter(county == "Warren")
union_p <- pop_density |>
  filter(county == "Union")
sussex_p <- pop_density |>
  filter(county == "Sussex")
somerset_p <- pop_density |>
  filter(county == "Somerset")
salem_p <- pop_density |>
  filter(county == "Salem")
passaic_p <- pop_density |>
  filter(county == "Passaic")
ocean_p <- pop_density |>
  filter(county == "Ocean")
morris_p <- pop_density |>
  filter(county == "Morris")
monmouth_p <- pop_density |>
  filter(county == "Monmouth")
middlesex_p <- pop_density |>
  filter(county == "Middlesex")
mercer_p <- pop_density |>
  filter(county == "Mercer")
hunterdon_p <- pop_density |>
  filter(county == "Hunterdon")
hudson_p <- pop_density |>
  filter(county == "Hudson")
gloucester_p <- pop_density |>
  filter(county == "Gloucester")
essex_p <- pop_density |>
  filter(county == "Essex")
cumberland_p <- pop_density |>
  filter(county == "Cumberland")
cape_may_p <- pop_density |>
  filter(county == "Cape May")
camden_p <- pop_density |>
  filter(county == "Camden")
burlington_p <- pop_density |>
  filter(county == "Burlington")
bergen_p <- pop_density |>
  filter(county == "Bergen")
atlantic_p <- pop_density |>
  filter(county == "Atlantic")

# The Figure  ----------------------------------------------------------------------------
# -section means "every column except section"

# Expect 16 rows: 4 sections x 4 measures
viol_crime_per_pop



# The UI (what the reader sees) ------------------------------------------------------------------

ui <- fluidPage(

  titlePanel("Best County to Raise Kids"),
  p("For: New Parents With Jobs in or Around New Jersey"),
  p("The decision: Which County Best Suits the Way they Wish to Raise their Children"),

  #selectInput(inputId = "pick", label = "Pick one:", choices = c("choice 1", "choice 2")),

  h3("Violent Crimes per 1000 Residents in Each County in Years 2018 to 2020"),
  plotOutput(outputId = "fig_1"),
  #p("a sentence or two saying what the figure shows."),

  h3("Population Density in Each County in Years 2018 to 2021"),
  plotOutput(outputId = "fig_2"),
  #p("a sentence or two saying what the figure shows."),

  h3("What this dashboard can not tell you"),
  #p("Limits of data.")

)


# The Server (how the figures are made) ----------------------------------------------------------

server <- function(input, output) {

  output$fig_1 <- renderPlot({

    ggplot(viol_crime_per_pop, aes(x = value, y = county)) +
      geom_col(data = warren_v, fill = "#000")+
      geom_col(data = union_v, fill = "#F70000")+
      geom_col(data = sussex_v, fill = "#2731F5")+
      geom_col(data = somerset_v, fill = "#DB00D8")+
      geom_col(data = salem_v, fill = "#3DFF62")+
      geom_col(data = passaic_v, fill = "#FF970F")+
      geom_col(data = ocean_v, fill = "#FFABAB")+
      geom_col(data = morris_v, fill = "#107D2D")+
      geom_col(data = monmouth_v, fill = "#1CFFFC")+
      geom_col(data = middlesex_v, fill = "#FEC7FF")+
      geom_col(data = mercer_v, fill = "#ECFF1C")+
      geom_col(data = hunterdon_v, fill = "#8500C7")+
      geom_col(data = hudson_v, fill = "#8769FF")+
      geom_col(data = gloucester_v, fill = "#A63D35")+
      geom_col(data = essex_v, fill = "#FAFFA3")+
      geom_col(data = cumberland_v, fill = "#00B4BA")+
      geom_col(data = cape_may_v, fill = "#A8FFBB")+
      geom_col(data = camden_v, fill = "#F7CB65")+
      geom_col(data = burlington_v, fill = "#7A7A7A")+
      geom_col(data = bergen_v, fill = "#FF6969")+
      geom_col(data = atlantic_v, fill = "#ddd")+
      facet_wrap(~ measure, scales = "free_x") +
      labs(
        #title = "Violent Crimes per 1000 Residents in Each County in Years 2018 to 2020",
        subtitle = "Data from New Jersey Data Book. Rutgers Center for Government Services, New Brunswick, NJ.  njdatabook.rutgers.edu ",
        x = NULL,
        y = NULL,
        #caption = "Lorum Ipsum"
      ) +
      theme_minimal()

  })

  output$fig_2 <- renderPlot({
    
    ggplot(pop_density, aes(x = value, y = county)) +
      geom_col(data = warren_p, fill = "#000")+
      geom_col(data = union_p, fill = "#F70000")+
      geom_col(data = sussex_p, fill = "#2731F5")+
      geom_col(data = somerset_p, fill = "#DB00D8")+
      geom_col(data = salem_p, fill = "#3DFF62")+
      geom_col(data = passaic_p, fill = "#FF970F")+
      geom_col(data = ocean_p, fill = "#FFABAB")+
      geom_col(data = morris_p, fill = "#107D2D")+
      geom_col(data = monmouth_p, fill = "#1CFFFC")+
      geom_col(data = middlesex_p, fill = "#FEC7FF")+
      geom_col(data = mercer_p, fill = "#ECFF1C")+
      geom_col(data = hunterdon_p, fill = "#8500C7")+
      geom_col(data = hudson_p, fill = "#8769FF")+
      geom_col(data = gloucester_p, fill = "#A63D35")+
      geom_col(data = essex_p, fill = "#FAFFA3")+
      geom_col(data = cumberland_p, fill = "#00B4BA")+
      geom_col(data = cape_may_p, fill = "#A8FFBB")+
      geom_col(data = camden_p, fill = "#F7CB65")+
      geom_col(data = burlington_p, fill = "#7A7A7A")+
      geom_col(data = bergen_p, fill = "#FF6969")+
      geom_col(data = atlantic_p, fill = "#ddd")+
      facet_wrap(~ measure, scales = "free_x") +
      labs(
        #title = "Population Density in Each County in Years 2018 to 2021",
        subtitle = "Data from New Jersey Data Book. Rutgers Center for Government Services, New Brunswick, NJ.  njdatabook.rutgers.edu ",
        x = NULL,
        y = NULL,
        #caption = "Lorum Ipsum"
      ) +
      theme_minimal()
    
  })

}


# Run the App ------------------------------------------------------------------------------------

shinyApp(ui = ui, server = server)

