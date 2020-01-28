package org.uma.mbd.mdAlturas;

import org.uma.mbd.mdAlturas.alturas.EnContinente;
import org.uma.mbd.mdAlturas.alturas.MenoresQue;
import org.uma.mbd.mdAlturas.alturas.Pais;
import org.uma.mbd.mdAlturas.alturas.Paises;

import java.io.FileNotFoundException;

public class MainPrueba {
    public static void main(String args[]) throws FileNotFoundException {
        Paises paises = new Paises();
        paises.leePaises("recursos/mdAlturas/alturas.txt");
        for (Pais pais : paises.selecciona(new MenoresQue(1.70))) {
            System.out.println(pais);
        }
        System.out.println();
        for (Pais pais : paises.selecciona(new EnContinente("Europe"))) {
            System.out.println(pais);
        }

    }
}
