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



