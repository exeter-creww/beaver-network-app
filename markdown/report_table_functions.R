bdc_data_table <- function(){

  bdc_d_tab <- tibble::tibble(
    `Variable Name` = c(
      "BDC","BDC_cat","BFI_10m","BFI_40m","BFI_cat","V_BDC","Dam_Prob",
      "Dam_ProbLC", "Dam_ProbUC","For_Prob","For_ProbLC","For_ProbUC",
      "Est_nDam", "Est_nDamLC", "Est_nDamUC", "Length_m", "Width_m",
      "Slope_perc", "Drain_Area", "Str_order", "Q2_Flow", "Q80_Flow",
      "Q2_StrPow",  "Q80_StrPow", "reach_no"
    ),
    `Variable Full Name` = c('Beaver Dam Capacity (dams/km)',
                             'Beaver Dam Capacity Category',
                             'Beaver Forage Index score within 10m of bank',
                             'Beaver Forage Index score within 40m of bank',
                             'Beaver Forage Index (Suitability) Category',
                             'Vegetation Beaver Dam Capacity (dams/km)',
                             'Probability of dam construction (mean)',
                             'Probability of dam construction (Lower 95% Credible interval)',
                             'Probability of dam construction (Upper 95% Credible interval)',
                             'Probability of Beaver Foraging (mean)',
                             'Probability of Beaver Foraging (Lower 95% Credible interval)',
                             'Probability of Beaver Foraging (Upper 95% Credible interval)',
                             'Estimated Number of dams (mean)',
                             'Estimated Number of dams (Lower 95% Confidence limit)',
                             'Estimated Number of dams (Upper 95% Confidence limit)',
                             'Reach Length (m)',
                             'Reach Width (m)',
                             'Reach slope (%)',
                             'Contributing Drainage Area (km2)',
                             'Stream Order (Strahler)',
                             'Flow at Q2 (m^-3 s^-1)',
                             'Flow at Q80 (m^-3 s^-1)',
                             'Stream Power at Q2 (watts/m)',
                             'Stream Power at Q80 (watts/m)',
                             'Unique Reach ID number'
    ),
    Description = c(
      "The maximum dam density that can be supported in a given reach. See
      (Graham et al., 2020; Macfarlane et al., 2017). Though individual reaches
      may reach capacity, whole catchments are extremely unlikely to reach
      capacity. For estimating (sub)catchment scale dam counts use 'Est_nDam'.",
      "A categorical string assigned based on the BDC value: (0 = None,
      0-1 = Rare, 1-4 = Occasional, 4-15 = Frequent, 15-30 = Pervasive)",
      "The mean of the upper 50% of Beaver Forage Index (BFI) values within 10m
      of the river bank. The Beaver Forage Index describes the suitability of a
      given vegetation type as beaver forage. Range from 0-5.",
      "The mean of the upper 50% of Beaver Forage Index (BFI) values within 40m
      of the river bank. This Metric is preferred over the 10m buffer when
      considering foraging habitat.",
      "A categorical value assigned based on BFI_40m to describe the forage
      preference of beaver for a particular vegetation type /landcover.
      (0-1 = Unsuitable, 1-2 = Low, 2-3 = Moderate, 3-4=High, 4-5 = Preferred)",
      "The maximum density of dams that can be supported in a given reach,
      considering vegetation only. No hydrologic of geomorphic parameters are
      used here. This intermediate metric may be useful in some instances to
      evaluate vegetation but we recommend the use of BDC to evaluate dam
      capacity and BFI_40m to evaluate forage suitability.)",
      "The probability that a given reach will be dammed by beaver, assuming
      that beaver are active in the reach (Graham et al., 2020).",
      "The lower 95% credible interval for the probability of dam construction,
      assuming that beaver are active in the reach.",
      "The upper 95% credible interval for the probability of dam construction,
      assuming that beaver are active in the reach.",
      "The probability that beaver will forage in a given reach, assuming that
      beaver are active within the catchment (Graham et al., 2020).",
      "The lower 95% credible interval for the probability of beaver foraging,
      assuming that beaver are active within the catchment.",
      "The upper 95% credible interval for the probability of beaver foraging,
      assuming that beaver are active within the catchment.",
      "The estimated number of dams in a given reach, if beaver are active
      within it. This value is to be used to quantify the likely number of
      dams that may occur at the sub-catchment scale (ca. >= 5 km2) as a
      minimum (Graham et al., 2020). For estimating the number of dams that may
      occur in a single reach (or beaver territory), 'BDC' is a more appropriate
      metric.",
      "The lower 95% confidence limit of dam estimates for a given reach. See
      'Est_nDam' description for further info.",
      "The upper 95% confidence limit of dam estimates for a given reach. See
      'Est_nDam' description for further info.",
      "The length of a given river reach.",
      "The mean width of a given river reach.",
      "The mean slope of a given river reach.",
      "The flow accumulation area for a given reach: i.e. the total area from
      which water flows into a reach.",
      "The stream order of a given reach, calculated using the Strahler method
      (Strahler, 1957)",
      "The estimated flow for a given reach at the Q2 exceedance level
      (98th percentile)",
      "The estimated flow for a given reach at the Q80 exceedance level (20th
      percentile)",
      "The Total Stream power for a given reach at the Q2 exceedance level.",
      "The Total Stream power for a given reach at the Q80 exceedance level.",
      "Integer to identify individual reaches."
    )
  )
  kableExtra::kbl(bdc_d_tab, longtable = T, booktabs = T,align = "c") %>%
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  font_size = 12) %>%
    column_spec(1, width = "10em") %>%
    column_spec(2, width = "20em") %>%
    column_spec(3, width = "50em")
}

bfi_defs <- function(){
  bfi_tab <- tibble::tibble(`BHI Values`=c(0:5),
    Definition = c(
      'Not suitable (no accessible vegetation)',
      'Not suitable (unsuitable vegetation)',
      'Barely Suitable',
      'Moderately Suitable',
      'Suitable',
      'Highly Suitable'
    )
  )

  kableExtra::kbl(bfi_tab, longtable = T, booktabs = T,align = "c") %>%
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  font_size = 12) %>%
    column_spec(1, width = "10em") %>%
    column_spec(2, width = "30em")
}


bdc_class <- function(){
  bdc_tab <- tibble::tibble(`BDC Classification`=c(
    'None',
    'Rare',
    'Occasional',
    'Frequent',
    'Pervasive'
  ),
  Definition = c(
    'No capacity for damming',
    'Max capacity for 0-1 dams/km',
    'Max capacity for 1-4 dams/km',
    'Max capacity for 5-15 dams/km',
    'Max capacity for 16-40 dams/km'
  )
  )

  kableExtra::kbl(bdc_tab, longtable = T, booktabs = T,align = "c") %>%
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  font_size = 12) %>%
    column_spec(1, width = "10em") %>%
    column_spec(2, width = "30em")
}


Data_inv <- function(){

  dat_inv <- tibble(`File Name` = c(
    "OpenBeaverNetwork_v1_0_gpkg.zip",
    "OpenBeaverNetwork_v1_0_shp.zip",
    "bfi_GB_1km_COG_EPSG27700_v0-6.tif",
    "bfi_GB_COG_EPSG27700_v0-6.tif"
  ),
  `Content Description` = c(
    'The BeaverNetwork dataset for Great Britain in
    Geopackage (.gpkg) format. It is a Polyline spatial vector dataset containing
    attributes for beaver dam capcity/suitabilty, estimated dam numbers, forage
    suitability, hydrometric/topographic variables such as stream power,
    gradient and stream width.',
    'The same BeaverNetwork dataset in ESRI Shapefile (.shp) format. All
    constituent files are stored in the compressed (.zip) folder.',
    'Coarse (Low) resolution (1 km) Beaver Habitat Index for Great Britain in
    Cloud Optimised Geotiff (.tif) format.',
    'Fine (High) resolution (10 m) Beaver Habitat Index for Great Britain. in
    Cloud Optimised Geotiff (.tif) format.'
    )
  )
  kableExtra::kbl(dat_inv, longtable = T, booktabs = T,align = "c") %>%
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  font_size = 12) %>%
    column_spec(1, width = "10em") %>%
    column_spec(2, width = "50em")

}
