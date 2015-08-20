# Programación Orientada a Objetos

Es este repositorio se presentan algunos conceptos básicos de programación orientada a objetos (OOP) en R, tomando en consideración solamente del modelo de objetos S3. Los objetos S3 fueron los primeros y más simples del sistema, pues fueron usados dentro del diseño de los paquetes base y stats. 

La mayoria de objetos dentro del sistema R son S3, desafortunadamente no existe una prueba simple para identificar un objeto de este tipo. Sin embargo, recomedamo hacer uso de las funciones: `is.object(x) & !isS4(x)` o `pryr::otype()` que permiten identificar los objetos S3.

