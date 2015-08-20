##################################
##### Ejercicios - Clases S3 #####
##################################

## Creando y modificando clases

# Para hacer un objeto una instancia de una clase tomaremos un objeto base existente y configuraremos el
# atributo de la clase, esto se puede realizar durante la creación de la estructura o después: class <- ()
# Ejemplo

# Creamos y asignamos la clase en un solo paso
diego <- structure(list(), class = "paul")
# Primero creamos, luego configuramos la clase
diego <- list()
class(diego) <- "paul"

# Creamos dos clases para el ejercicio práctico del capítulo
oneDie <- list(trials=character(0))
class(oneDie) <- "Die"

oneCoin <- list(trials=character(0))
class(oneCoin) <- "Coin"

# Podemos determinar la clase de un objeto por medio de la función "class", además podemos ver si un objeto 
# hereda de una clase especifica usando "inherits(x, "classname")".

class(oneDie)
class(oneCoin)
inherits(oneDie, "Die")
inherits(oneCoin, "Coin")

# La clase de un objeto S3 puede ser un vector, el cual describe el comportamiento desde el mayor a menor 
# especificado

counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
print(d.AD <- data.frame(treatment, outcome, counts))
glmD93 <- glm(counts ~ outcome + treatment, family = poisson())
class(glmD93)
# El resultado anterior nos muestra que los modelos lineales generalizados heredan el comportamiento desde
# los modelos lineales

## Creando métodos y funciones genéricas

# Para agregar un nuevo genérico, creamos una función que llame a "UseMethod". UseMethod toma dos argumentos: 
# 1) el nombre de la función genérica, 2) argumento que utiliza para el método de envío. Si se omite el segundo
# argumento se enviará en el primer argumento de la función.

f <- function(x) UseMethod("f")
f.Diego <- function(x) "Clase Diego"
a <- structure(list(), class = "Diego")
class(a)
f(a)

# Un genérico no es útil sin método alguno. Para agregar un métoda basta agregar un función con el nombre correcto:
# generic.class

# Adicionamos un método al genérico existente:
mean.Diego <- function(x) "Media para la Clase Diego"
mean(a)

# Los metodos corresponden a funciones llamadas "genericas". Para determinar si una función es S3 genérica 
# se debe inspeccionar el código fuente, dentro del código se encontrará el llamado a "UseMethod"
# Algunas funciones genericas como sum, "[", etc. no hacen el llamado a "UseMethod" pues las mismas se 
# encuentran implementadas en C.
reset <- function(theObject){
      UseMethod("reset", theObject)
      print("Reset the Trials")
}

# Los metodos S3 son fácilmente reconocibles por sus nombres: generic.class()
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

# Dada una clase, el trabajo de una función S3 genérica es realizar el llamado correcto del método
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

# Para revisar todos los metodos que pertenecen a una función genérica usamos: "methods()"
# Para leer el código fuente de los métodos no visibles usamos: "getS3method()"

# Agregamos el genérico "simulateGeometric"
simulateGeometric <- function(theObject, returnResults=FALSE){
      UseMethod("simulateGeometric", theObject)
      print("Not sure what to do here!\n")
}

# Definimos el método para "Die"
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

# Definimos el método para "Coin"
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

# Ejecutamos los nuevos métodos
oneDie <- list(trials=character(0))
class(oneDie) <- "Die"
simulateGeometric(oneDie, TRUE)
simulateGeometric(oneDie, FALSE)

oneCoin <- list(trials=character(0))
class(oneCoin) <- "Coin"
simulateGeometric(oneCoin, TRUE)
simulateGeometric(oneCoin, FALSE)

## Método Dispatch (Expedición - Envío)






