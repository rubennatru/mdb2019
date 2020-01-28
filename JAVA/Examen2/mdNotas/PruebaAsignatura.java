package org.uma.mbd.mdNotas;

import org.uma.mbd.mdNotas.notas.*;

public class PruebaAsignatura {
        private static String[] alumnos = {
                "12455666F;Lopez Perez, Pedro;6.7",
                "33678999D;Merlo Gomez, Isabel;5.8",
                "23555875G;Martinez Herrera, Lucia;9.1"};

    public static void main(String[] args){
        Asignatura asignatura = new Asignatura("POO");
        try {
            asignatura.leeDatos(alumnos);
            CalculoMedia m1 = new MediaAritmetica();
            System.out.println("Media de la asignatura " + asignatura.getNombre() + ": " + asignatura.getMedia(m1));

            System.out.println("Alumnos: ");

            for(Alumno alumno : asignatura.getAlumnos()) {
                System.out.println(alumno.getDni());
            }
            System.out.println();
            System.out.println(asignatura.getAlumnos().get(0).getCalificacion());


            System.out.println();
            Alumno alu2 = new Alumno("12455666F", "Lopez Lopez, Pedro", 6.7);
            System.out.println("Nueva Media de la asignatura " + asignatura.getNombre() + ": " + asignatura.getMedia(m1));
            System.out.println("Calificación del alumno alu2: " + alu2 + ": " + asignatura.getCalificacion(alu2));

        }catch (AlumnoException e) {
            System.err.println(e.getMessage());
        }
    }
}