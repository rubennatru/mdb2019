package org.uma.mbd.mdNotas;

import org.uma.mbd.mdNotas.notas.Alumno;
import org.uma.mbd.mdNotas.notas.AlumnoException;

public class PruebaAlumno {
    public static void main(String[] args) {
        try {
            Alumno a1 = new Alumno("22456784F", "Gonzalez Perez, Juan", 5.5);
            Alumno a2 = new Alumno("33456777S", "Gonzalez Perez, Juan", 3.4);
            System.out.println(a1);
            System.out.println(a2);

            if (a1.equals(a2)){
                System.out.println("Los alumnos son iguales");
            }
            a2 = new Alumno("33456777S", "Gonzalez Perez, Juan", -3.4);
            System.out.println(a2);

        }catch(AlumnoException e){
            System.err.println(e.getMessage());
        }
    }
}
