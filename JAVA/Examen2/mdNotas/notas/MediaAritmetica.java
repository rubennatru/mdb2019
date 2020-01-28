package org.uma.mbd.mdNotas.notas;

import java.util.List;

public class MediaAritmetica implements CalculoMedia {

	@Override
	public double calcular(List<Alumno> als) throws AlumnoException{
		int nAlus = 0;
		double sumaNotas = 0;

		if(als.size() == 0){
			throw new AlumnoException("No se disponen de Alumnos para el cálculo");
		}

		for(Alumno al : als) {
			try {
				sumaNotas += al.getCalificacion();
				nAlus++;
			} catch (ArrayIndexOutOfBoundsException e) {
				throw new AlumnoException("Nota Errónea. Alumno: " + al);
			}
		}
		return sumaNotas/nAlus;
	}
}