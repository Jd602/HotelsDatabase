module hotelsdatabase {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires java.desktop;
    requires ojdbc10;
    requires static lombok;

    opens hotelsdatabase to javafx.fxml;
    exports hotelsdatabase;

    opens hotelsdatabase.controlador to javafx.fxml;
    exports hotelsdatabase.controlador;

    opens hotelsdatabase.modelo.db to javafx.fxml;
    exports hotelsdatabase.modelo.db;

    opens hotelsdatabase.modelo.entidad to javafx.fxml;
    exports hotelsdatabase.modelo.entidad;

}