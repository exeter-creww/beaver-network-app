
build_base_leaf <- function(){

  beav_net <- readRDS('**[DATA-PATH]**')

  bdc_pal <- c('#0D0D0D', '#E66C00', '#FFDE22', '#35DF03', '#035ADF')
  bfi_pal <-c("#0B0405FF", "#3E356BFF", "#357BA2FF", "#49C1ADFF", "#DEF5E5FF") #mako(5)

  pal1 <- colorFactor(
    palette = bdc_pal,
    domain = beav_net$BDC_cat)

  # pal2 <- colorFactor(
  #   palette = bfi_pal,
  #   domain = beav_net$BFI_cat)

  COG_leaf_pal <- colorFactor(
    palette = bfi_pal,
    domain = c("1 - Unsuitable",
               "2 - Low",
               "3 - Moderate",
               "4 - High",
               "5 - Preferred")
  )

  logo <- "**[INSERT-URL]**"
  lmap <- leaflet() %>%
    addProviderTiles(providers$CartoDB.Positron, group = "light") %>%
    addProviderTiles(providers$CartoDB.DarkMatter, group = "dark") %>%
    addProviderTiles("OpenStreetMap.HOT", group = "Open Street Map") %>%
    addProviderTiles(provider = "Esri.WorldImagery",
                     group='Esri World Imagery',
                     options =providerTileOptions(opacity=0.9)) %>%
    setView(lng = -1.7, lat = 54.2, zoom = 6) %>%
    addLogo(img =logo, width=400, src='remote') %>%

    addSearchOSM() %>%

    addMouseCoordinates() %>%

    addLegend("bottomright", pal = COG_leaf_pal, values = c("1 - Unsuitable",
                                                            "2 - Low",
                                                            "3 - Moderate",
                                                            "4 - High",
                                                            "5 - Preferred"),
              title = "Beaver Habitat Index",
              opacity = 0.8,
              group="Beaver Habitat Index") %>%

    addLegend("bottomright",
              colors =  bdc_pal,
              labels = c('None: 0', 'Rare: 0-1', 'Occasional: 1-4', 'Frequent: 4-15', 'Pervasive: 15-30'),
              # pal = pal1, values = beav_net$BDC_cat,
              title = "Beaver Dam Capacity (dams/km)",
              opacity = 0.7, group="Beaver Dam Capacity") %>%

    # addLegend("bottomright",
    #           colors= bfi_pal,
    #           labels = c('Unsuitable: 0-1', 'Low: 1-2', 'Moderate: 2-3', 'High: 3-4', 'Preferred: 4-5'),
    #           # pal = pal2, values = beav_net$BFI_cat,
    #           title = "Beaver Forage Index",
    #           opacity = 0.7, group="Beaver Forage Index") %>%


    addLayersControl(
      baseGroups = c("light", "dark","Open Street Map", "Esri World Imagery")
      , overlayGroups = c("Beaver Dam Capacity",
                          # "Beaver Forage Index",
                          "Beaver Habitat Index")) %>%
    hideGroup(c(
      # "Beaver Forage Index",
      "Beaver Habitat Index"))

  return(list(lmap, pal1, bfi_pal, COG_leaf_pal, beav_net))
}


add_leaf_lyrs <- function(leaf_prox, leaf_atts, beav_net){

  pal1 <- leaf_atts[[2]]
  # pal2 <- leaf_atts[[3]]
  bfi_pal <- leaf_atts[[3]]
  COG_leaf_pal <- leaf_atts[[4]]
  beav_net <-leaf_atts[[5]]

  COGurl<- '**[INSERT-URL]**'

  COG_cols <- paste(shQuote(bfi_pal), collapse=", ")
  COG_vals <-paste(shQuote(c(1:5)), collapse=", ")

  leaf_prox %>%

    addMapPane("cog", zIndex = 400) %>%
    addMapPane("bdc", zIndex = 500) %>%

    leafem:::addCOG(
      url = COGurl
      , group = "Beaver Habitat Index"
      , layerId= "BHI"
      , opacity = 0.7
      , options = list(pane = "cog")
      , resolution = 65
      , autozoom = FALSE
      , pixelValuesToColorFn = JS(paste0(
        "function (values) {
           var scale = chroma.scale([",COG_cols,"]).domain([",COG_vals,"]);
           var bhi = values[0];
           if (bhi === 0) return;
           return scale(bhi).hex();
     }")
      )
    ) %>%

    leafgl::addGlPolylines(map = .,
                           data = beav_net,
                           color= ~pal1(BDC_cat),
                           weight=0.5,
                           options = list(pane = "bdc"),
                           group="Beaver Dam Capacity",
                           layerId='lines1',
                           src=TRUE,
                           digits=4) #%>%

    # leafgl::addGlPolylines(map = .,
    #                        data = beav_net,
    #                        color= ~pal2(BFI_cat),
    #                        weight=0.5,
    #                        group="Beaver Forage Index",
    #                        layerId='lines2',
    #                        src=TRUE,
    #                        digits=4)

}
