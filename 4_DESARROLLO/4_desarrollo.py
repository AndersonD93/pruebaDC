def segunda_calificacion_menor(Lista):
    try:
        if len(Lista) < 2 or len(Lista) > 5:
            print("La lista debe tener al menos 2 elementos y como máximo 5 elementos.")
            return
        
        # Se ordena por medio de la clave de la lista y luego por su valor alfabetico
        Lista.sort(key=lambda x: (x[1], x[0]))
        
        # De la lista ordenada se obtendra la segunda calificación más baja
        segunda_calificacion = Lista[1][1]
        
        # Se crea una nueva lista con los nombres de los estudiantes con la calificación igual a segunda_calificacion
        estudiantes_segunda_calificacion = [estudiante[0] for estudiante in Lista if estudiante[1] == segunda_calificacion]
        
        # Organizar la lista resultante de forma alfabetica
        estudiantes_segunda_calificacion.sort()
        
        print("Estudiantes con la segunda calificación más baja:")
        for estudiante in estudiantes_segunda_calificacion:
            print(estudiante)
    
    #Se controla el error en cuanto a la cantidad de sublistas dentro de la lista.
    except ValueError as ve:
        print(f"Error: {ve}")


Lista = [["omega", 20.0], ["beta", 50.0], ["alpha", 50.0], ["epsilon", 50.0],["theta",75.0]]
segunda_calificacion_menor(Lista)