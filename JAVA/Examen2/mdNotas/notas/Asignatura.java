package org.uma.mbd.mdNotas.notas;

import java.io.File;
import java.io.IOException;
import java.util.*;


public class Asignatura {
    private String nombre;
    private List<Alumno> alumnos;
    private List<String> errores;

    private static final double APROBADO = 5;
    private static final String DNI = "[0-9]{8}[A-Z&&[^IOU]]";

    public Asignatura(String nombreAsignatura) {
        this.nombre = nombreAsignatura;
        errores = new ArrayList<>();
        this.alumnos = new ArrayList<>();
    }

    public String getNombre() {
        return nombre;
    }

    public void leeDatos(String nombreFichero) throws IOException {
        try (Scanner sc = new Scanner(new File(nombreFichero))){
            List<String> listAlu = new ArrayList<>();
            while (sc.hasNextLine()) {
                listAlu.add(sc.nextLine());
            }
            listAlu.stream().toArray();
            leeDatos((String[]) listAlu.stream().toArray(String[]::new));
        }
    }

    public void leeDatos(String[] datos) {
        for (String dato: datos) {
            stringAAlumno(dato);
        }
    }


    private void stringAAlumno(String linea) {
        try (Scanner sc = new Scanner(linea)) {
            sc.useDelimiter("[;]+");
            sc.useLocale(Locale.ENGLISH);
            String dni = sc.next();
            String nom = sc.next();
            double cal = sc.nextDouble();
            Alumno alu = new Alumno(dni, nom, cal);
            if (!dni.matches(DNI)){
                throw new AlumnoException("DNI incorrecto: ");
            }
            alumnos.add(alu);

        } catch (AlumnoException e) {
            errores.add(e.getMessage() + linea);
        } catch (InputMismatchException e) {
            errores.add("Nota no Numérica: " + linea);
        } catch (NoSuchElementException e) {
            errores.add("Faltan datos en: " + linea);
        }
    }

    public double getCalificacion(Alumno al) throws AlumnoException {
        int i = 0;
        while (i < alumnos.size() &&  (!(al.equals(alumnos.get(i))))) {
            i++;
        }
        if(i == alumnos.size()){
            throw new AlumnoException("No existe el alumno: " + al);
        }
        return alumnos.get(i).getCalificacion();
    }

    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public List<String> getErrores() {return errores; }

    public Set<String> getNombreAlumnos() {
        Set<String> setNombres = new HashSet<>();

        for(Alumno alu: alumnos){
            setNombres.add(alu.getNombre());
        }
        return setNombres;
    }


    public double getMedia(CalculoMedia media) throws AlumnoException {
        return media.calcular(alumnos);
    }


    public Set<Alumno> getAlumnos(Comparator<Alumno> comp){
        Set<Alumno> setAlu = new TreeSet<>(comp);
        setAlu.addAll(setAlu);

        return setAlu;
    }

    public Map<Character, Set<Alumno>> getAlumnosInicial() {
        Comparator<Alumno> oNotas = (al1, al2)-> Double.compare(al1.getCalificacion(), al2.getCalificacion());
        Map<Character, Set<Alumno>> map = new TreeMap<>();

        for(Alumno alu : alumnos)
        {
            Character inicial = alu.getNombre().charAt(0);
            Set<Alumno> set = map.computeIfAbsent(inicial, line -> new TreeSet<>(oNotas.reversed().thenComparing(Comparator.naturalOrder())));
            set.add(alu);
        }
        return map;
    }


    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(nombre);
        sb.append(alumnos);
        sb.append(errores);
        return sb.toString();
    }
}