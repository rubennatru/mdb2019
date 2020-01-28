package org.uma.mbd.mdNotas.notas;

public class Alumno implements Comparable<Alumno>{
    private String nombre;
    private String dni;
    private double nota;

    public Alumno(String d, String n, double c) throws AlumnoException {
        dni = d;
        this.nombre = n;
        this.nota = c;

        if(nota < 0){
            throw new AlumnoException("Calificación Negativa: ");
        }
    }

    public Alumno(String d, String n) throws AlumnoException {
        dni = d;
        this.nombre = n;
        nota = 0;

        if(nota < 0){
            throw new AlumnoException("Calificación Negativa: ");
        }
    }

    @Override
    public boolean equals(Object obj) {
        boolean res = obj instanceof Alumno;
        Alumno al = res ? (Alumno)obj : null;
        return res && al.nombre.equalsIgnoreCase(nombre) && al.dni.equalsIgnoreCase(dni);
    }

    @Override
    public int hashCode() {
        return nombre.hashCode() + dni.toUpperCase().hashCode();
    }

    public String getNombre() {
        return nombre;
    }

    public String getDni() {
        return dni;
    }

    public double getCalificacion() {
        return nota;
    }

    @Override
    public int compareTo(Alumno alu) {
        int res = nombre.compareTo(alu.nombre);
        if (res == 0){
            res = dni.compareToIgnoreCase(alu.dni);
        }
        return res;
    }

    public String toString() {
        return nombre + " " + dni;
    }
}
