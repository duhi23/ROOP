##################################
##### Ejercicios - Clases S3 #####
##################################

oneDie <- list(trials=character(0))
class(oneDie) <- "Die"

oneCoin <- list(trials=character(0))
class(oneCoin) <- "Coin"

# Contruimos una función para resetear los valores
reset <- function(theObject){
      UseMethod("reset", theObject)
      print("Reset the Trials")
}

reset.default <- function(theObject){
      print("Uh oh, not sure what to do here!\n")
      return(theObject)
}

reset.Die <- function(theObject){
      theObject$trials <- character(0)
      print("Reset the die\n")
      return(theObject)
}

reset.Coin <- function(theObject){
      theObject$trials <- character(0)
      print("Reset the coin\n")
      return(theObject)
}

# Verificamos el uso de la función "reset"
oneDie$trials = c("3","4","1")
oneDie$trials

oneDie <- reset(oneDie)
oneDie

oneCoin$trials = c("H","H","T")
oneCoin <- reset(oneCoin)
oneCoin$trials

# Ejemplo que produce un error y usa la función por defecto.

v <- c(1,2,3)
v <- reset(v)
v



simulateGeometric <- function(theObject, returnResults=FALSE){
      UseMethod("simulateGeometric", theObject)
      print("Not sure what to do here!\n")
}

simulateGeometric.Die <- function(theObject, returnResults=FALSE){
      cat("Performing the simulations on the die\n")
      # First reset the trials and start the simulation
      theObject <- reset(theObject)
      repeat{
            # Roll a die and get a value.
            thisRoll <- 1 + trunc(runif(1, 0, 6));
            
            # Add this to the end of the set of results as a
            # character string..
            theObject$trials = append(theObject$trials, as.character(thisRoll))
            
            if(thisRoll <= 1){
                  # They rolled a one.  Time to stop!
                  break
            }
      }
      
      if(returnResults) {
            return(as.factor(theObject$trials))
      } else {
            return(theObject)
      }
      
}



simulateGeometric.Coin <- function(theObject, returnResults=FALSE){
      cat("Performing the simulations on the coin\n")
      theObject <- reset(theObject)
      # First reset the trials and start the simulation
      repeat{
            # Flip a coin and get a value.
            thisFlip <- runif(1, 0, 2);
            if(thisFlip <= 1){
                  # They flipped a heads, append this event as a
                  # character to the end and then stop!
                  theObject$trials = append(theObject$trials,"H")
                  break
            }
            # This was not a one. Just add this to the end of the
            # set of results as a character string..
            theObject$trials = append(theObject$trials,as.character("T"))
      }
      if(returnResults) {
            return(as.factor(theObject$trials))
      } else {
            return(theObject)
      }
}



oneDie <- list(trials=character(0))
class(oneDie) <- "Die"
simulateGeometric(oneDie, TRUE)

simulateGeometric(oneDie, FALSE)

oneCoin <- list(trials=character(0))
class(oneCoin) <- "Coin"
simulateGeometric(oneCoin, TRUE)
simulateGeometric(oneCoin, FALSE)
