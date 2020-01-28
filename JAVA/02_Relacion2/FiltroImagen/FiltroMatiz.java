package org.uma.mbd.mdFiltroImagen.filtroImagen;

import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;

public class FiltroMatriz implements FiltroImagen {
    private int dimension;
    private float[] mascara;

    public FiltroMatriz(int d, float[] mas) {
        dimension = d;
        mascara = mas;
    }

    public void filtra(BufferedImage image) {
        Kernel kernel = new Kernel(dimension, dimension, mascara);
        BufferedImageOp bright = new ConvolveOp(kernel);
        BufferedImage convolvedImage = bright.filter(image, null);
        image.getGraphics().drawImage(convolvedImage, 0, 0, null);
    }

    public static FiltroMatriz creaFiltroMedia() {
        float[] mascara =
                {1.0f / 9.0f, 1.0f / 9.0f, 1.0f / 9.0f,
                        1.0f / 9.0f, 1.0f / 9.0f, 1.0f / 9.0f,
                        1.0f / 9.0f, 1.0f / 9.0f, 1.0f / 9.0f};

        return new FiltroMatriz(3, mascara);
    }

    // creaFiltroBordes

    // creaFiltroEnfoque

    // creaFiltroBrillo

}