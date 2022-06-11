package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class TipoHospedaje {

    @Getter
    private final int id;

    @Getter
    private final String nombre;

    public String toString() {
        return nombre;
    }

}
