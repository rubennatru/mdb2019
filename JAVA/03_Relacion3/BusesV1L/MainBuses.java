package org.uma.mbd.mdBusV1L;

import org.uma.mbd.mdBusV1.buses.Criterio;
import org.uma.mbd.mdBusV1.buses.EnMatricula;
import org.uma.mbd.mdBusV1.buses.PorLinea;
import org.uma.mbd.mdBusV1.buses.Servicio;

import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class MainBuses {
    public static void main(String [] args) {
        Servicio servicio = new Servicio("Malaga");
        try {
        	System.out.println(servicio.getCiudad());
            servicio.leeBuses("recursos/mdBusV1/buses.txt");
            Criterio cr1 = new PorLinea(21);
            servicio.guarda("recursos/mdBusV1/linea21.txt", cr1);
            servicio.guarda(new PrintWriter(System.out,true), cr1);
            Criterio cr2 = new EnMatricula("29");
            servicio.guarda("recursos/mdBusV1/contiene29.txt", cr2);
            servicio.guarda(new PrintWriter(System.out,true), cr2);
        } catch (FileNotFoundException e) {
            System.err.println("No existe el fichero de entrada");
        }
    }
}
