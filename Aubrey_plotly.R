# plotly - A way to create interactive graphs
# november 27, 2018
# SB

# Plotly - useful for online graphs an identifying invividual data points easily

library(plotly)
plot_ly(z= ~volcano)

# two main ways to get a plotly object 

# plot-ly()  transform data directly into the object 
data <- mpg
p0 <- plot_ly(data = data, x= ~displ, y= ~cty)
p0

# ggplotly() turns ggplots into plotly object
p1 <- ggplot(data=data, mapping=aes(x=displ, y=cty)) + geom_point()
p1
ggplotly(p1)

# can add "layers" with plotly:
head(txhousing)
allCities <- txhousing %>%
  group_by(city) %>%
  plot_ly(x= ~date, y= ~median) %>%
  add_lines(alpha=0.2, name="Texam Cities", hoverinfo = "none")
allCities

allCities %>%
  filter(city == "Houston") %>%
  add_lines(name = "Houston")

# To add more cities, use add_fun 

allCities %>%
  add_fun(function(plot) {
    plot %>% 
      filter(city == "Houston") %>% 
      add_lines(name = "Houston")}) %>%
  add_fun(function(plot) {
    plot %>% filter(city == "Abilene") %>%
      add_lines(name= "Abilene")
  })


# can also be used for 3D plots
plot_ly(data=iris, x=~Sepal.Length,y=~Sepal.Width,z=~Petal.Length,type="scatter3d",mode='markers',size=~Petal.Width,color=~Species)

# Add animations 
df <- data.frame(
  x = c(1:5,4:1), 
  y = c(1:5, 4:1), 
  f = c(1:9)
)

p <- plot_ly(data=df, x = ~x, y = ~y, frame = ~f, type = 'scatter',transition= ~f, mode = 'markers', showlegend = TRUE)

p


