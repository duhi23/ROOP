##########################
##### Script - ggvis #####
##########################

# 1) The grammar of graphics

# Change the code below to make a graph with red points
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points()

# Change the code below draw smooths instead of points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# Change the code below to make a graph containing both points and a smoothed summary line
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

# Make a scatterplot of the pressure dataset
pressure %>% ggvis(~temperature, ~pressure) %>% layer_points()

# Adapt the code you wrote for the first challenge: show bars instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()

# Adapt the code you wrote for the first challenge: show lines instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Adapt the code you wrote for the first challenge: map the fill property to the temperature variable
pressure %>% ggvis(~temperature, ~pressure, fill=~temperature ) %>% layer_points()

# Extend the code you wrote for the previous challenge: map the size property to the pressure variable
pressure %>% ggvis(~temperature, ~pressure, fill=~temperature, size=~pressure) %>% layer_points()

# 2) Lines and syntax

# Rewrite the code with the pipe operator  
faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points()

# Modify this graph to map the size property to the pressure variable
pressure %>% ggvis(~temperature, ~pressure, size = ~pressure) %>% layer_points()

# Modify this graph by setting the size property
pressure %>% ggvis(~temperature, ~pressure, size := 100) %>% layer_points()

# Fix this code to set the fill property to red
pressure %>% ggvis(~temperature, ~pressure, fill := "red") %>% layer_points()

# Change the second line of code to set the fills using pressure$black
pressure$black <- c("black", "grey80", "grey50", 
                    "navyblue", "blue", "springgreen4", 
                    "green4", "green", "yellowgreen", 
                    "yellow", "orange", "darkorange", 
                    "orangered", "red", "magenta", "violet", 
                    "purple", "purple4", "slateblue")
pressure %>% 
      ggvis(~temperature, ~pressure, 
            fill := ~black) %>% 
      layer_points()

# Plot the faithful data as described in the second instruction
faithful %>% 
      ggvis(~waiting, ~eruptions, 
            size = ~eruptions, opacity := 0.5, 
            fill := "blue", stroke := "black") %>% 
      layer_points()

# Plot the faithful data as described in the third instruction
faithful %>% 
      ggvis(~waiting, ~eruptions, 
            fillOpacity = ~eruptions, size := 100,  
            fill := "red", stroke := "red", shape := "cross") %>% 
      layer_points()


# Change the code below to use the lines mark
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Set the properties described in the second instruction in the graph below
pressure %>% ggvis(~temperature, ~pressure, stroke:="red", strokeWidth:=2, strokeDash:=6) %>% layer_lines()

# Change the code below to use the lines mark
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Set the properties described in the second instruction in the graph below
pressure %>% ggvis(~temperature, ~pressure, stroke:="red", strokeWidth:=2, strokeDash:=6) %>% layer_lines()

# Compute the x and y coordinates for a loess smooth line that predicts mpg with the wt
mtcars %>% compute_smooth(mpg ~ wt)

# Use 'ggvis()' and 'layer_lines()' to plot the results of compute smooth
mtcars %>% compute_smooth(mpg ~ wt) %>% ggvis(~pred_, ~resp_) %>% layer_lines()

# Recreate the graph you coded above with 'ggvis()' and 'layer_smooths()' 
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# Extend the code for the second plot and add 'layer_points()' to the graph
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

# 3) Transformations

# Build a histogram of the waiting variable of the faithful data set.
faithful %>% ggvis(~waiting) %>% layer_histograms()

# Build the same histogram, but with a binwidth of 5 units
faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)

# Transform the code below: just compute the bins instead of plotting a histogram
faithful %>% compute_bin(~waiting, width=5)

# Combine the solution to the first challenge with layer_rects() to build a histogram
faithful %>% compute_bin(~waiting, width=5) %>% ggvis(x=~xmin_, x2=~xmax_, y=0, y2=~count_) %>% layer_rects()

# Combine compute_density() with layer_lines() to make a density plot of the waiting variable.
faithful %>% compute_density(~waiting) %>% ggvis(~pred_, ~resp_) %>% layer_lines()

# Build a density plot directly using layer_densities. Use the correct variables and properties.
faithful %>% ggvis(~waiting) %>% layer_densities(fill := "green")

# Complete the code to plot a bar graph of the cyl factor.
mtcars %>% ggvis(~factor(cyl)) %>% layer_bars()

# Adapt the solution to the first challenge to just calculate the count values. No plotting!
mtcars %>% compute_count(~factor(cyl))

# Change the code to plot a unique smooth line for each value of the cyl variable.
mtcars %>% group_by(cyl) %>% ggvis(~mpg, ~wt, stroke = ~factor(cyl)) %>% layer_smooths()

# Adapt the graph to contain a separate density for each value of cyl.
mtcars %>% group_by(cyl) %>% ggvis(~mpg) %>% layer_densities()

# Copy and alter the solution to the second challenge to map the fill property to a categorical version of cyl.
mtcars %>% group_by(cyl) %>% ggvis(~mpg, fill=~factor(cyl)) %>% layer_densities()

# Alter the graph below: separate density for each unique combination of 'cyl' and 'am'.
mtcars %>% group_by(cyl, am) %>% ggvis(~mpg, fill = ~factor(cyl)) %>% layer_densities()

# Update the graph below to map `fill` to the unique combinations of the grouping variables.
mtcars %>% group_by(cyl, am) %>% ggvis(~mpg, fill = ~interaction(cyl,am)) %>% layer_densities()

# 4) Interactivity and layers

# Run this code and inspect the output. Follow the link in the instructions for the interactive version
faithful %>% 
      ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
            shape := input_select(label = "Choose shape:", 
                                  choices = c("circle", "square", "cross", "diamond", 
                                              "triangle-up", "triangle-down"))) %>% 
      layer_points()

# Copy the first code chunk and alter the code to make the fill property interactive using a select box
faithful %>% 
      ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
            shape := input_select(label = "Choose shape:", 
                                  choices = c("circle", "square", "cross", "diamond", 
                                              "triangle-up", "triangle-down")),
            fill:= input_select(label="Choose color:",
                                choices = c("black", "red", "blue", "green"))) %>% 
      layer_points()

# Add radio buttons to control the fill of the plot
mtcars %>% 
      ggvis(~mpg, ~wt, fill:= input_radiobuttons(label="Choose color", choices=c("black", "red", "blue", "green"))) %>% 
      layer_points()


# Change the radiobuttons widget in the first command on the right to a text widget that displays the 
# initial value "black". The wanted resulting plot can be found here.
mtcars %>% 
      ggvis(~mpg, ~wt, 
            fill := input_text(label = "Choose color", value = "black")) %>% 
      layer_points()

# In the second graph on the right, map fill to a select box that returns variable names. The select 
# box should use the label "Choose fill variable:" and should offer the choices created by names(mtcars), 
# as shown here. Use the map argument inside input_select() to map the selection instead of setting it.
mtcars %>% 
      ggvis(~mpg, ~wt, 
            fill = input_select(label = "Choose fill variable:", 
                                choices = names(mtcars), map = as.name)) %>% 
      layer_points()


# Map the bindwidth to a numeric field ("Choose a binwidth:")
mtcars %>% 
      ggvis(~mpg) %>% 
      layer_histograms(width = 2)

mtcars %>% 
      ggvis(~mpg) %>% 
      layer_histograms(width = input_numeric(1, label = "Choose a binwidth:"))

# Map the binwidth to a slider bar ("Choose a binwidth:") with the correct specifications
mtcars %>% 
      ggvis(~mpg) %>% 
      layer_histograms(width = input_slider(1, 20, value = 11, label="Choose a binwidth:"))


# Add a layer of points to the graph below.
pressure %>% 
      ggvis(~temperature, ~pressure, stroke := "skyblue") %>% 
      layer_lines()

pressure %>% 
      ggvis(~temperature, ~pressure, stroke := "skyblue") %>% 
      layer_lines() %>% layer_points()

# Copy and adapt the solution to the first instruction below so that only the lines layer uses a skyblue stroke.
pressure %>% 
      ggvis(~temperature, ~pressure, stroke := "skyblue") %>% 
      layer_points()         

# Rewrite the code below so that only the points layer uses the shape property.
pressure %>% 
      ggvis(~temperature, ~pressure) %>% 
      layer_lines(stroke := "skyblue") %>% 
      layer_points(shape := "triangle-up")

# Refactor the code for the graph below to make it as concise as possible
pressure %>% 
      ggvis(~temperature, ~pressure, stroke := "skyblue", strokeOpacity := 0.5, strokeWidth := 5) %>% 
      layer_lines(~temperature, ~pressure, stroke := "skyblue", strokeOpacity := 0.5, strokeWidth := 5) %>% 
      layer_points(~temperature, ~pressure,fill = ~factor(temperature), strokeOpacity := 0.5, 
                   shape := "triangle-up", stroke := "skyblue", size := 300, strokeWidth := 5)

pressure %>% 
      ggvis(~temperature, ~pressure, stroke := "skyblue", strokeOpacity := 0.5, strokeWidth := 5) %>% 
      layer_lines() %>% 
      layer_points(fill = ~factor(temperature), 
                   shape := "triangle-up", size := 300)

# Create a graph containing a scatterplot, a linear model and a smooth line.
# Create a scatterplot of the pressure data set that has the temperature variable on the x axis and the 
# pressure variable on the y axis. Connect the points with a black line that has 50% opacity. Then add 
# a linear model line to the data that is navy in color. Then add a smooth line that is skyblue in color.

pressure %>% ggvis(~temperature, ~pressure) %>% layer_points() %>% 
      layer_lines(stroke:="black", opacity := 0.5) %>% layer_model_predictions(model = "lm", stroke := "navy") %>%
      layer_smooths(stroke:="skyblue")

# 5) Customizing Axes, Legends

# The code for the first graph on the right changes the title of the Y axis to “Duration of eruption (m)”. 
# Add to the code to change the title of the x axis to “Time since previous eruption (m)”.

faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>% 
      add_axis("y", title = "Duration of eruption (m)")

faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>% 
      add_axis("y", title = "Duration of eruption (m)") %>%
      add_axis("x", title = "Time since previous eruption (m)")

# The second code chunk places a labelled tick mark at each integer on the y axis and then inserts nine 
# subdividing tickmarks between each integer. Add to the code to place a labelled tick mark at 50, 60, 
# 70, 80, 90 on the x axis. Place nine subdividing tick marks between each labelled tick mark.
faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>% 
      add_axis("y", title = "Duration of eruption (m)", 
               values = c(2, 3, 4, 5), subdivide = 9) %>% 
      add_axis("x", title = "Time since previous eruption (m)")

faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>% 
      add_axis("y", title = "Duration of eruption (m)", 
               values = c(2, 3, 4, 5), subdivide = 9) %>% 
      add_axis("x", title = "Time since previous eruption (m)",
               values = c(50, 60, 70, 80, 90), subdivide = 9)

# Change the sample code for the last graph: move the y axis to the right side of the plot. Move the x 
# axis to the top of the plot.
faithful %>% 
      ggvis(~waiting, ~eruptions) %>% 
      layer_points() %>%
      add_axis("y", orient = "right") %>%
      add_axis("x", orient = "top")


# Use add_legend() to change the title of the legend in the first plot on the right to “~ duration (m)” 
# and to orient the legend to the left side of the graph.
faithful %>% 
      ggvis(~waiting, ~eruptions, opacity := 0.6, 
            fill = ~factor(round(eruptions))) %>% 
      layer_points()

faithful %>% 
      ggvis(~waiting, ~eruptions, opacity := 0.6, 
            fill = ~factor(round(eruptions))) %>% 
      layer_points() %>%
      add_legend("fill", title = "~ duration (m)", orient = "left")

# Use add_legend() to combine the legends in the second plot. Also set the legend title to “~ duration (m)” 
# and specify that only the values 2, 3, 4, and 5 should receive a labelled symbol.
faithful %>% 
      ggvis(~waiting, ~eruptions, opacity := 0.6, 
            fill = ~factor(round(eruptions)), shape = ~factor(round(eruptions)), 
            size = ~round(eruptions))  %>%
      layer_points()

faithful %>% 
      ggvis(~waiting, ~eruptions, opacity := 0.6, 
            fill = ~factor(round(eruptions)), shape = ~factor(round(eruptions)), 
            size = ~round(eruptions)) %>% 
      layer_points() %>% 
      add_legend(c("fill", "shape", "size"), 
                 title = "~ duration (m)", values = c(2, 3, 4, 5))

# Add to the first chunk of code to make the stroke color range from “darkred” to “orange”.
mtcars %>% 
      ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
      layer_points() %>%
      scale_numeric("fill", range = c("red", "yellow"))

mtcars %>% 
      ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
      layer_points() %>%
      scale_numeric("fill", range = c("red", "yellow")) %>%
      scale_numeric("stroke", range = c("darkred", "orange"))

# Change the graph below to make the fill colors range from green to beige.
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>%
      layer_points()
      
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>%
      layer_points() %>%
      scale_numeric("fill", range = c("green", "beige"))

# The third code chunk on the right maps a categorical (e.g., nominal variable) to fill. Create a scale 
# that will map factor(cyl) to a new range of colors: purple, blue, and green. Since factor(cyl) has 
# three unique values, the range of your scale will need three unique color names.
mtcars %>% ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>%
      layer_points()

mtcars %>% ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>%
      layer_points() %>%
      scale_nominal("fill", range = c("purple", "blue", "green"))

# Consider the first code chunk in the editor. Add a scale that limits the range of opacity from 0.2 to 1. 
# Be sure to consider whether hp is a datetime, logical, nominal, numeric, or singular value.
mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~factor(cyl), opacity = ~hp) %>%
      layer_points()

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~factor(cyl), opacity = ~hp) %>%
      layer_points() %>%
      scale_numeric("opacity", range = c(0.2, 1))

# Read the code for the second graph carefully. Add a second scale that will expand the x axis to cover 
# data values from 0 to 6.
mtcars %>% ggvis(~wt, ~mpg, fill = ~disp) %>%
      layer_points() %>%
      scale_numeric("y", domain = c(0, NA))

mtcars %>% ggvis(~wt, ~mpg, fill = ~disp) %>%
      layer_points() %>%
      scale_numeric("y", domain = c(0, NA)) %>%
      scale_numeric("x", domain = c(0, 6))

# Set the fill value to the color variable instead of mapping it, and see what happens
mtcars$color <- c("red", "teal", "#cccccc", "tan")
mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~color) %>% layer_points()

# Set the fill value to the color variable instead of mapping it, and see what happens
mtcars$color <- c("red", "teal", "#cccccc", "tan")
mtcars %>% ggvis(x = ~wt, y = ~mpg, fill := ~color) %>% layer_points()
