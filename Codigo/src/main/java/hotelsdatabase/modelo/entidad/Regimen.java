package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class Regimen {

    @Getter
    private final int id;

    @Getter
    private final String descripcion;

    @Override
    public String toString() {
        return this.descripcion;
    }

}
