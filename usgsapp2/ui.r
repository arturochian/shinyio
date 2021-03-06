require("shiny")
require("rCharts")
require("sacbox")
require("spocc")
require("rgbif")
require("rbison")
require("taxize")

options(shiny.table.class = "table data table-striped table-condensed table-bordered")

shinyUI(pageWithSidebar(

  headerPanel(title=HTML("TaxaViewer - <i>Species exploration</i> "), windowTitle="TaxaViewer"),

  sidebarPanel(

    includeHTML('assets.html'),

      HTML('<style type="text/css">
         .row-fluid .span4{width: 26%;}
         .leaflet {height: 600px; width: 830px;}
         </style>'),

      HTML('
         <style type="text/css">
          .btn-submit {float: left;}
         </style>'),

      HTML('
           <button style="float: left;" type="submit" class="btn btn-primary">Submit</button>
           <br><br>
           '),

      h5(strong("Input taxon names:")),
      # includeHTML('egsmodal.html'),

      HTML('<textarea id="spec" rows="3" cols="50">Carpobrotus,Rosmarinus,Ageratina</textarea>'),

    # downstream options for ITIS Children tabe
      h5(strong("Downstream options:")),
      selectInput(inputId="downto", label="Select taxonomic level to retrieve", choices=c("Class","Order","Family","Genus","Species"), selected="Species"),

    # Map options
      h5(strong("Map options:")),
      # data source
      selectInput(inputId="datasource", label="Select data source", choices=c("gbif","ecoengine"), selected="gbif"),
      # number of occurrences for map
      sliderInput(inputId="numocc", label="Select max. number of occurrences to search for per species", min=0, max=500, value=50),
      # color palette for map
      selectInput(inputId="palette", label="Select color palette",
                  choices=c("Blues","BlueGreen","BluePurple","GreenBlue","Greens","Greys","Oranges","OrangeRed","PurpleBlue","PurpleBlueGreen","PurpleRed","Purples","RedPurple","Reds","YellowGreen","YellowGreenBlue","YlOrBr","YellowOrangeRed",
                            "BrownToGreen","PinkToGreen","PurpleToGreen","PurpleToOrange","RedToBlue","RedToGrey","RedYellowBlue","RedYellowGreen","Spectral"), selected="Blues"),
      selectInput('provider', 'Select map provider for interactive map',
                  choices = c("OpenStreetMap.Mapnik","OpenStreetMap.BlackAndWhite","OpenStreetMap.DE","OpenCycleMap","Thunderforest.OpenCycleMap","Thunderforest.Transport","Thunderforest.Landscape","MapQuestOpen.OSM","MapQuestOpen.Aerial","Stamen.Toner","Stamen.TonerBackground","Stamen.TonerHybrid","Stamen.TonerLines","Stamen.TonerLabels","Stamen.TonerLite","Stamen.Terrain","Stamen.Watercolor","Esri.WorldStreetMap","Esri.DeLorme","Esri.WorldTopoMap","Esri.WorldImagery","Esri.WorldTerrain","Esri.WorldShadedRelief","Esri.WorldPhysical","Esri.OceanBasemap","Esri.NatGeoWorldMap","Esri.WorldGrayCanvas","Acetate.all","Acetate.basemap","Acetate.terrain","Acetate.foreground","Acetate.roads","Acetate.labels","Acetate.hillshading"),
                  selected = 'MapQuestOpen.OSM'
      ),

#      includeHTML('providersmodal.html'),

      h5(strong("Papers options:")),
      sliderInput(inputId="paperlim", label="Number of papers to return", min=1, max=50, value=10, step=1, ticks=TRUE)

#      includeHTML('infomodal.html')

  ),

  mainPanel(
    tabsetPanel(
      tabPanel("Classification",
      # includeHTML('classmodal.html'),
        dataTableOutput("rank_names")),
      tabPanel("Downstream",
      # includeHTML('childrenmodal.html'),
               HTML('<style type="text/css">#children{height:600px;overflow:auto;}</style>'),
               dataTableOutput("children")),
      # tabPanel("Phylogeny",
      # includeHTML('phylogenymodal.html'),
      #  plotOutput("phylogeny")),
      tabPanel("Map",
      # includeHTML('mapmodal.html'),
        mapOutput('map_rcharts')),
      tabPanel("Papers",
      # includeHTML('papersmodal.html'),
       htmlOutput('papers'))
    )
  # includeHTML('gauges.html')
  )
))
