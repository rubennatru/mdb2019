package org.uma.mbd.mdNotas.notas;

import java.util.List;

public class MediaArmonica implements CalculoMedia{

	@Override
	public double calcular(List<Alumno> als) throws AlumnoException {
		double sumaNotas = 0;
		int k = 0;

		if(als.size() == 0){
			throw new AlumnoException("No se disponen de Alumnos para el cálculo");
		}

		for(Alumno al : als) {
			try {
				double nota = al.getCalificacion();

				if(nota > 0){
					sumaNotas += 1/nota;
					k++;
				}
			} catch (ArrayIndexOutOfBoundsException e) {
				throw new AlumnoException("Error en la nota del alumno: " + al);
			}
		}

		if(k == 0){
			throw new AlumnoException("No hay alumnos con notas mayores a 0.");
		}

		return k/sumaNotas;
	}
}