shinyUI(pageWithSidebar(
  headerPanel('Cluster analysis on Iris data set'),
  sidebarPanel(
    selectInput('coloring', 'Color by', c("By cluster", "By ground truth")),
    selectInput('clusterMethod', 'Cluster method',
                c("kmeans", "hierarchical")),
    sliderInput('clusters', 'Cluster count', 3, min = 2, max = 10),
    h1("What is this"),
    p("This application allows you to try different clustering
      algorithms on the iris data set. You can control the type of clustering
      as well as the number of clusters. Furthermore you can color either by
      the cluster results, or by the ground truth: Species"),
    p("Additionally, we perform PCA on the data and disply the first two
      principal components to see how well the projection captures the structure
      as found by the clustering methods. (NOTE: for some reason this works
      locally, but not on shinyapps.io.")
  ),
  mainPanel(
    plotOutput('plot1'),
    plotOutput('pcaPlot')
  )
))
