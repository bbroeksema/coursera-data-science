library(GGally)
library(ggplot2)
library(FactoMineR)

data(iris)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
  # Avoid randomness in analytical methods (such as kmeans) by using a fixed
  # seed.
  set.seed(255)

  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, 1:4]
  })

  coloring <- function() {
    if (input$coloring == "By cluster") {
      cluster()
    } else {
      iris$Species
    }
  }

  cluster <- reactive({
    if (input$clusterMethod == "kmeans") {
      as.factor(kmeans(scale(selectedData()), input$clusters)$cluster)
    } else if (input$clusterMethod == "hierarchical") {
      distance <- dist(scale(selectedData()))
      as.factor(cutree(hclust(distance), input$clusters))
    } else {
      as.factor(rep(1, nrow(iris)))
    }
  })

  color <- reactive({
    coloring()
  })

  output$plot1 <- renderPlot({
    iris$cluster <<- color()
    ggpairs(data = iris, columns = 1:4, color="cluster")
  })

  output$pcaPlot <- renderPlot({
    pca <- PCA(iris[,1:4])
    dat <- as.data.frame(pca$ind$coord[, c("Dim.1", "Dim.2")])
    dat$cluster <- as.factor(color())

    p <- ggplot(dat, aes(x = Dim.1, y = Dim.2, color=cluster))
    p <- p + geom_point()
    print(p)
  })

})
