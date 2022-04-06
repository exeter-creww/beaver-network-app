library(markdown)
library(shiny)
library(shinythemes)
library(leaflet)
library(leafgl)
library(leafem)
library(magrittr)
library(shinycssloaders)
library(leaflet.extras)
library(viridisLite)
library(shinymanager)
source("leaf_map_modules.R")


css <- HTML(" body {
    background-color: #464646;
}")




inactivity <- "function idleTimer() {
var t = setTimeout(logout, 120000);
window.onmousemove = resetTimer; // catches mouse movements
window.onmousedown = resetTimer; // catches mouse movements
window.onclick = resetTimer;     // catches mouse clicks
window.onscroll = resetTimer;    // catches scrolling
window.onkeypress = resetTimer;  //catches keyboard actions

function logout() {
window.close();  //close the window
}

function resetTimer() {
clearTimeout(t);
t = setTimeout(logout, 120000);  // time is in milliseconds (1000 is 1 second)
}
}
idleTimer();"

password <- Sys.getenv("SHINY_PASS")

# data.frame with credentials info
credentials <- data.frame(
  user = c("WildLifeTrust"),
  password = password,
  is_hashed_password = TRUE,
  # comment = c("alsace", "auvergne", "bretagne"), %>%
  stringsAsFactors = FALSE
)

ui <- secure_app(head_auth = tags$script(inactivity),
                 theme=shinytheme("cosmo"),
                 fab_position = "bottom-left",
                 {
                   navbarPage(title=div(div( "Open Beaver Network")
                   ),
                   # Themeing...
                   tags$head(tags$style(css)
                   ),
                   theme=shinytheme("cosmo"),

                   # Map UI
                   tabPanel("Map",
                            fillPage(
                              withSpinner(leafglOutput("Map", height = "92vh"),
                                          type=8,color="#9AE6D9", hide.ui = FALSE,
                                          proxy.height = 250)
                            )
                   )
                   ,
                   # About section...
                   navbarMenu("About",
                              tabPanel("Summary",
                                       fluidRow(
                                         style = "max-height: 92vh; overflow-y: auto; color:white" ,
                                         column(9, offset=1,
                                                includeHTML("markdown/summary.html")
                                         )
                                       )
                              ),
                              tabPanel("Detail",
                                       fluidRow(
                                         style = "max-height: 92vh; overflow-y: auto; color:white" ,
                                         column(9, offset=1,
                                                includeHTML("markdown/detail.html")
                                         )
                                       )
                              )

                   ),
                   # Beaver Network Download ...
                   navbarMenu("Download: BeaverNetwork-GB",
                              tabPanel(a("GeoPackage (172MB)",
                                         href="**[INSERT-URL]**"
                                         ,target="_blank"
                              )
                              ),
                              tabPanel(a("ESRI Shapefile (352MB)",
                                         href="**[INSERT-URL]**"
                                         ,target="_blank"
                              )
                              ),

                   ),

                   # Beaver Habitat INdex Download
                   navbarMenu("Download: Beaver Habitat Index (BHI)",
                              tabPanel(a("GeoTIFF-10m (179MB)",
                                         href="**[INSERT-URL]**",
                                         target="_blank")),
                              tabPanel(a("GeoTIFF-1km (903 KB)",
                                         href="**[INSERT-URL]**",
                                         target="_blank"))


                   ),

                   )})

server <- function(input, output, session) {

  result_auth <- secure_server(check_credentials = check_credentials(credentials))

  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })

  # Render the Map
  m1 <- build_base_leaf()
  output$Map <- renderLeaflet(m1[[1]])

  proxy <- leafletProxy("Map")
  add_leaf_lyrs(proxy, m1)

}


shinyApp(ui = ui, server = server)
