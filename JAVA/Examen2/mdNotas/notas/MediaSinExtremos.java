package org.uma.mbd.mdNotas.notas;

import java.util.List;

public class MediaSinExtremos implements CalculoMedia{
    private double min;
    private double max;

    public MediaSinExtremos(double min, double max){
        this.min = min;
        this.max = max;
    }

    @Override
    public double calcular(List<Alumno> als) throws AlumnoException{
        int nAlus = 0;
        double sumaNotas = 0;

        if(als.size() == 0){
            throw new AlumnoException("No se disponen de Alumnos para el cálculo");
        }
        List<Alumno> auxList = null;

        for(Alumno al : als) {
            try {
                double nota = al.getCalificacion();

                if (min <= nota && nota <= max) {
                    sumaNotas += nota;
                    nAlus ++;
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                throw new AlumnoException("Nota Errónea. Alumno: " + al);
            }
        }

        double mediaSExtrem  = sumaNotas/nAlus;

        return mediaSExtrem;
    }
}