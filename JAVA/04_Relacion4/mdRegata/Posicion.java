package org.uma.mbd.mdRegata.regata;

public class Posicion {
	/** 
	 * Variable privada que representa la longitud de una posición en grados decimales.
	 */
	private double longitud;
	
	/**
	 * Variable privada que representa la latidud de una posicion en grados decimales.
	 */
	private double latitud;
	
	/**
	 * Constante que representa la media del radio de la Tierra.
	 * Utilizada para calcular la distancia entre dos puntos geográficos.
	 */
	private static final String NORTE = "N";
	private static final String SUR = "S";
	private static final String ESTE = "E";
	private static final String OESTE = "W";
	
	
	/**
	 * Crea una posicion a partir de una latitud y longitud proporcionada 
	 * como argumentos. Tanto una como otra se normalizan para mantener la
	 * latitud entre -90 y 90 y la longitud entre -180 y 179.
	 * @param lat  	latitud
	 * @param lon	longitud
	 */
	public Posicion(double lat, double lon) {
		latitud = normalizaLatitud(lat);
		longitud = normalizaLongitud(lon);
	}

	public Posicion(int gl, double ml, int gL, double mL) {
		latitud = normalizaLatitud(gl+ml/60);
		longitud = normalizaLongitud(gL + ((gL<0)?-1:1)*mL/60);
	}
	
	/**
	 * Devuelve la latitud
	 * @return la latitud
	 */
	public double getLatitud() {
		return latitud;
	}
	
	/**
	 * Devuelve la longitud
	 * @return la longitud
	 */
	public double getLongitud() {
		return longitud;
	}
		
	/**
	 * Método auxiliar para normalizar una latitud y que el resultado se encuentre entre -90 y 90
	 * @param lat 	latitud no normalizada
	 * @return 		latitud normalizada
	 */
	public static double  normalizaLatitud(double lat) {
		double res = lat % 360;
		if (res < 0) res += 360;
		// res es un numero entre 0 y 360
		int signo = (res < 180) ? 1 : -1;
		res = (res <= 90 || (res >= 180 && res <= 270))? res % 90 : 90 - res % 90;
		return signo*res;  // Entre -90 y 90
	}
	
	/**
	 * Método auxiliar para normalizar la longitud y que el resultado se mantenga entre -180 y 180.
	 * @param lon 	longitud no normalizada
	 * @return 		longitud normalizada
	 */
	public static double normalizaLongitud(double lon) {
		double res = lon % 360;
		if (res < 0) res += 360;
		// res es un numero entre 0 y 360
		if (res > 180) 
			res = res - 360;
		return res;  // Entre -180 y 180
	}

	/**
	 * Calcula la distancia loxodrómica
	 * @param p posicion
	 * @return la distancia en millas
	 */
	public double distancia(Posicion p) {
		// Pasamos longitudes y latitudes a radianes
		double incrl = Math.abs(p.latitud - latitud) * 60; // incremento de latitud en millas
		double incrLA = Math.abs(p.longitud - longitud);
		// Si es mayor de 180 es mas corto por el otro lado del globo
		if (incrLA > 180) {
			incrLA = 360 - incrLA;
		} 
		double incrL = incrLA * 60; // incremento de latitud en millas
		double lm = (latitud + p.latitud)/2; // longitud media del trayecto
		double apartamiento = incrL * Math.cos(Math.toRadians(lm)); // Apartamiento en millas
		return Math.sqrt(Math.pow(apartamiento, 2) + Math.pow(incrl, 2));	 // Distancia
	}
	
	public double rumbo(Posicion p) {
		String l = NORTE;
		String L = ESTE; 
		if (latitud > p.latitud) {
			l = SUR;
		} 
		if (longitud > p.longitud) {
			L = OESTE;
		} 	
		double incrl = Math.abs(p.latitud - latitud) * 60; // incremento de latitud en millas
		double incrLA = Math.abs(p.longitud - longitud);
		// Si es mayor de 180 es mas corto por el otro lado del globo
		if (incrLA > 180) {
			incrLA = 360-incrLA;
			L = (L == ESTE) ? OESTE: ESTE;
		} 
		double incrL = incrLA*60; // incremento de latitud en millas
		double lm = (latitud + p.latitud)/2; // longitud media del trayecto
		double apartamiento = incrL*Math.cos(Math.toRadians(lm)); // Apartamiento en millas
		double rumbo = 90;
		if (incrl != 0) {
			rumbo = Math.toDegrees(Math.atan(apartamiento/incrl));	
		}
		if (l == SUR && L == OESTE) {
			rumbo += 180;
		} else if (l == SUR && L == ESTE) {
			rumbo = 180 - rumbo;
		} else if (L == OESTE) {
			rumbo = 360 - rumbo;
		}
		return rumbo;
	}
	
	/**
	 * Devuelve una estimación de la posicion final que se alcanza si se parte de la posicion receptora y 
	 * se avanza durante los minutos dados como primer argumento en el rumbo y velocidad dados como 
	 * segundo y tercer argumentos, respectivamente.
	 * @param minutos	Tiempo en minutos durante los que se avanza
	 * @param rumbo		Rumbo en el que se avanza (entre 0 y 359 grados decimales)
	 * @param velocidad	Velocidad a la que se avanza (millas/h)
	 * @return 			Posicion a la que se llega
	 */
	
	public Posicion posicionTrasRecorrer(int minutos, double rumbo, double velocidad) {
		/*
		 *               
		 *               A                    
		 *           ---------           ---------
		 *           |       /           |       /
		 *           |      /            |      /
		 *           |     /             |     /
		 *           |    / D          A |    / incrL
		 *     incrl |   /               |   /
		 *           |  /                |lm/
		 *           |R/                 | /
		 *           |/                  |/
		 *           
		 *   A = Apartamiento (millas)
		 *   D = Distancia Recorrida (millas)
		 *   R = Rumbo (grados)
		 *   incrl = incremento de longitud (millas) 
		 *   incrL = incremento de latitud (millas)
		 *   lm = longitud media del trayecto (grados) 
		 *   
		 *   ** Loxodromica Directa
		 *   Se conoce:
		 *     - Posicion de salida (ls,Ls)
		 *     - Rumbo
		 *     - Distancia recorrida
		 *   Se pide
		 *     - Posicion de llegada (lf,Lf) 
		 *   Solucion   
		 *     A = D * sin R
		 *     incrl = D * cos R
		 *     lm = ls + incrl/2
		 *     incrL = A / cos lm
		 *     lf = ls + incrl
		 *     Lf = Ls + incrL
		 *     
		 *   ** Loxodromica Inversa
		 *   Se conoce
		 *     - Posicion de salida (ls, Ls)
		 *     - Posicion de llegada (lf, Lf)
		 *   Se pide
		 *     - Rumbo
		 *     - Distancia
		 *   Solucion
		 *     incrl = lf - ls (en millas)
		 *     incrL = Lf - Ls (en millas)
		 *     lm = (ls + lf) / 2
		 *     A = incrL * cos lm  (en millas)
		 *     D = raiz( A*A + incrl*incrl)
		 *     R = atan(A/incrl)  
		 *                
		 */
		String l = NORTE;
		String L = ESTE;
		double angulo = rumbo%360;
		if (angulo < 0) {
			angulo += 360;
		}
		if (angulo >= 270) {
			angulo = 360 - angulo;
			L = OESTE;
		} else if (angulo >= 180) {
			angulo = angulo - 180;
			l = SUR;
			L = OESTE;
		} else if (angulo > 90) {
			angulo = 180 - angulo;
			l = SUR;
		}
		double rumboRad = Math.toRadians(angulo); // Rumbo en radianes
		double distanciaMillas = (velocidad/1.60934)*minutos/60; // distancia en millas
		double apartamiento = distanciaMillas*Math.sin(rumboRad); // apartamiento en millas
		double incrl = distanciaMillas*Math.cos(rumboRad)/60; // incremento de logitud en grados
		double lm = latitud + incrl/2; // longitud media del trayecto
		double incrL = apartamiento/Math.cos(Math.toRadians(lm))/60; // incremento de latitud en grados
		double nLatitud  = latitud + ((l == NORTE) ? incrl : -incrl);
		double nLongitud = longitud + ((L == ESTE) ? incrL : -incrL); 
		return new Posicion(nLatitud, nLongitud);	// nueva posicion
	}
	
	@Override
	/**
	 * Representación textual de una posición como:
	 * 		l= latitud L= longtud
	 */
	public String toString() {
		return String.format("l= %5.2f L= %5.2f", latitud, longitud);
	}
}
