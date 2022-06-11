package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class Hospedaje {

    @Getter
    private final int id;

    @Getter
    private final String nombre;

    @Getter
    private final String cancelaciones;

    @Getter
    private final TipoHospedaje tipoHospedaje;

    @Getter
    private final List<Regimen> regimenes;

}
