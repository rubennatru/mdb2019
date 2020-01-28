package org.uma.mbd.mdCanciones;

import org.uma.mbd.mdCanciones.canciones.Reproductor;
import org.uma.mbd.mdCanciones.canciones.ReproductorDuracion;

import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class PruebaReproductor {

	public static void main(String[] args) {
//		Reproductor reproductor = new Reproductor();
		Reproductor reproductor = new ReproductorDuracion();
		try {
			// Añadimos al reproductor varias listas de reproducción
			reproductor.anyadirLista("footing", "recursos/mdCanciones/footing.txt");
			reproductor.anyadirLista("sobremesa", "recursos/mdCanciones/sobremesa.txt");
			reproductor.anyadirLista("fiesta", "recursos/mdCanciones/fiesta.txt");

			// Obtenemos por pantalla la salida de las tres listas
			PrintWriter pw = new PrintWriter(System.out, true);
			reproductor.reproducir("footing", pw);
			reproductor.reproducir("sobremesa", pw);
			reproductor.reproducir("fiesta", pw);

			// Obtenemos en un fichero la salida de la lista "footing"
			reproductor.reproducir("footing", "recursos/mdCanciones/footingSalida.txt");
			
		} catch (FileNotFoundException e) { // Capturamos excepción de fichero no encontrado
			System.out.println("Error de E/S " + e.getMessage());
		} catch (RuntimeException e) { // Cualquier otra excepción debe corresponder con un error de formato
			System.out.println("Formato de fichero erroneo: " + e.getMessage());
		}
	}

}
