package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class Vehiculo {

    private final String placa;
    private final String marca;
    private final String tipo;
    private final int capacidad;
    private final int valorPorDia;
    private final String gama;
    private final String estado;

}
