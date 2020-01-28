package org.uma.mbd.mdNotas;
import org.uma.mbd.mdNotas.notas.*;

import java.io.IOException;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class Main2 {
    public static void main(String[] args) throws IOException {
        Asignatura algebra = new Asignatura("Algebra");

        try {
            algebra.leeDatos("recursos/mdNotas/notas.txt");
            Alumno al1 = new Alumno("23322443k", "Lopez Turo, Manuel");
            Alumno al2 = new Alumno("342424f2J", "Fernandez Vara, Pedro");
            System.out.println("Calificacion de " + al1 + ": "
                    + algebra.getCalificacion(al1));
            System.out.println("Calificacion de " + al2 + ": "
                    + algebra.getCalificacion(al2));
        } catch (AlumnoException e) {
            System.err.println(e.getMessage());
        }
        try {
            CalculoMedia m1 = new MediaAritmetica();
            CalculoMedia m2 = new MediaArmonica();
            double min = 5.0;
            double max = 9.0;
            CalculoMedia m3 = new MediaSinExtremos(min,max);

            System.out.print("Media aritmetica ");
            System.out.println(algebra.getMedia(m1));
            System.out.print("Media armonica ");
            System.out.println(algebra.getMedia(m2));
            System.out.print("Media de valores en ["+min+","+max+"] ");
            System.out.println(algebra.getMedia(m3));
        } catch (AlumnoException e) {
            System.out.println("Error "+ e.getMessage());
        }
        System.out.println("Alumnos...");
        algebra.getAlumnos().forEach(
                alumno -> System.out.println(alumno + ": " + alumno.getCalificacion()));

        System.out.println("Malos...");
        algebra.getErrores().forEach(System.out::println);
        System.out.println("La asignatura completa");
        System.out.println(algebra);

        System.out.println();
        System.out.println("Nombre de los alumnos");
        algebra.getNombreAlumnos().forEach(System.out::println);



        //------------------------------------- datos ordenados  ---------------------------------------

        Comparator<Alumno> oNotas = (al1, al2)-> Double.compare(al1.getCalificacion(), al2.getCalificacion());
        Comparator<Alumno> oNombre = (al1, al2)-> al1.getNombre().compareTo(al2.getNombre());
        Comparator<Alumno> oDNI = (al1, al2)-> al1.getDni().compareTo(al2.getDni());

        System.out.println();
        System.out.println("Alumnos ordenados por notas, a igualdad de notas por nombre y a igualdad de nombres por dni");
        Set<Alumno> ordenA = algebra.getAlumnos(oNotas.thenComparing(Comparator.naturalOrder()));
        ordenA.addAll(algebra.getAlumnos());
        ordenA.forEach(alumno -> System.out.println(alumno + ": " + alumno.getCalificacion()));


        System.out.println();
        System.out.println("Alumnos ordenados por dni descendentes");
        Set<Alumno> ordenB = algebra.getAlumnos(oDNI.reversed());
        ordenB.addAll(algebra.getAlumnos());
        ordenB.forEach(alumno -> System.out.println(alumno + ": " + alumno.getCalificacion()));



        System.out.println();
        System.out.println("Correspondencia de alumnos por inicial");

        Map<Character, Set<Alumno>> map = algebra.getAlumnosInicial();
        for (Character k: map.keySet()) {
            System.out.println(k);
            Set<Alumno> set = map.get(k);
            for (Alumno alu : set) {
                System.out.println("\t" + alu + " " + alu.getCalificacion());
            }
        }
    }
}
