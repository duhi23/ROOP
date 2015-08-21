##########################
##### Script - ggvis #####
##########################

faithful %>% 
      ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
            shape := input_select(label = "Choose shape:", 
                                  choices = c("circle", "square", "cross", "diamond", 
                                              "triangle-up", "triangle-down"))) %>% 
      layer_points()


mtcars %>% 
      ggvis(~mpg, ~wt, fill:= input_radiobuttons(label="Choose color", choices=c("black", "red", "blue", "green"))) %>% 
      layer_points()