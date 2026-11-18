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
  ) |>
  select(county, violent_crime_per_pop_2018, violent_crime_per_pop_2019, violent_crime_per_pop_2020)

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

warren <- viol_crime_per_pop |>
  filter(county == "Warren")
union <- viol_crime_per_pop |>
  filter(county == "Union")
sussex <- viol_crime_per_pop |>
  filter(county == "Sussex")
somerset <- viol_crime_per_pop |>
  filter(county == "Somerset")
salem <- viol_crime_per_pop |>
  filter(county == "Salem")
passaic <- viol_crime_per_pop |>
  filter(county == "Passaic")
ocean <- viol_crime_per_pop |>
  filter(county == "Ocean")
morris <- viol_crime_per_pop |>
  filter(county == "Morris")
monmouth <- viol_crime_per_pop |>
  filter(county == "Monmouth")
middlesex <- viol_crime_per_pop |>
  filter(county == "Middlesex")
mercer <- viol_crime_per_pop |>
  filter(county == "Mercer")
hunterdon <- viol_crime_per_pop |>
  filter(county == "Hunterdon")
hudson <- viol_crime_per_pop |>
  filter(county == "Hudson")
gloucester <- viol_crime_per_pop |>
  filter(county == "Gloucester")
essex <- viol_crime_per_pop |>
  filter(county == "Essex")
cumberland <- viol_crime_per_pop |>
  filter(county == "Cumberland")
cape_may <- viol_crime_per_pop |>
  filter(county == "Cape May")
camden <- viol_crime_per_pop |>
  filter(county == "Camden")
burlington <- viol_crime_per_pop |>
  filter(county == "Burlington")
bergen <- viol_crime_per_pop |>
  filter(county == "Bergen")
atlantic <- viol_crime_per_pop |>
  filter(county == "Atlantic")

# The Figure  ----------------------------------------------------------------------------
# -section means "every column except section"

# Expect 16 rows: 4 sections x 4 measures
viol_crime_per_pop



# The UI (what the reader sees) ------------------------------------------------------------------

ui <- fluidPage(

  titlePanel("your title"),
  p("For: who is making the decision"),
  p("The decision: the one decision this dashboard helps with"),

  selectInput(inputId = "pick", label = "Pick one:", choices = c("choice 1", "choice 2")),

  h3("Figure 1. title"),
  plotOutput(outputId = "fig_1"),
  p("a sentence or two saying what the figure shows."),

  h3("Figure 2. title"),
  plotOutput(outputId = "fig_2"),
  p("a sentence or two saying what the figure shows."),

  h3("What this dashboard cannot tell you"),
  p("the limits of your data.")

)


# The Server (how the figures are made) ----------------------------------------------------------

server <- function(input, output) {

  output$fig_1 <- renderPlot({

    ggplot(viol_crime_per_pop, aes(x = value, y = county)) +
      geom_col(data = warren, fill = "#000")+
      geom_col(data = union, fill = "#F70000")+
      geom_col(data = sussex, fill = "#2731F5")+
      geom_col(data = somerset, fill = "#DB00D8")+
      geom_col(data = salem, fill = "#3DFF62")+
      geom_col(data = passaic, fill = "#FF970F")+
      geom_col(data = ocean, fill = "#FFABAB")+
      geom_col(data = morris, fill = "#107D2D")+
      geom_col(data = monmouth, fill = "#1CFFFC")+
      geom_col(data = middlesex, fill = "#FEC7FF")+
      geom_col(data = mercer, fill = "#ECFF1C")+
      geom_col(data = hunterdon, fill = "#8500C7")+
      geom_col(data = hudson, fill = "#8769FF")+
      geom_col(data = gloucester, fill = "#A63D35")+
      geom_col(data = essex, fill = "#FAFFA3")+
      geom_col(data = cumberland, fill = "#00B4BA")+
      geom_col(data = cape_may, fill = "#A8FFBB")+
      geom_col(data = camden, fill = "#F7CB65")+
      geom_col(data = burlington, fill = "#7A7A7A")+
      geom_col(data = bergen, fill = "#FF6969")+
      geom_col(data = atlantic, fill = "#ddd")+
      facet_wrap(~ measure, scales = "free_x") +
      labs(
        title = "Violent Crimes per 1000 Residents in Each County in Years 2018 to 2020",
        #subtitle = "Sample",
        x = NULL,
        y = NULL,
        #caption = "Lorum Ipsum"
      ) +
      theme_minimal()

  })

  output$fig_2 <- renderPlot({

    ggplot()     # replace with your code for Figure 2

  })

}


# Run the App ------------------------------------------------------------------------------------

shinyApp(ui = ui, server = server)

