shinyUI(pageWithSidebar(
  headerPanel('Cluster analysis on Iris data set'),
  sidebarPanel(
    selectInput('coloring', 'Color by', c("By cluster", "By ground truth")),
    selectInput('clusterMethod', 'Cluster method',
                c("kmeans", "hierarchical")),
    sliderInput('clusters', 'Cluster count', 3, min = 2, max = 10)
  ),
  mainPanel(
    plotOutput('plot1'),
    plotOutput('pcaPlot')
  )
))
