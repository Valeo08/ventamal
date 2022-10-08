package valeo.ventamal.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * @author Valeo
 */
public class DateManager {
    
    public static String getNombreMes(final Timestamp _fecha) {
        SimpleDateFormat formato = new SimpleDateFormat("MMMM", Locale.UK);
        Date fecha = new Date(_fecha.getTime());
        return formato.format(fecha);
    }
    
    public static String getAgno(final Timestamp _fecha) {
        SimpleDateFormat formato = new SimpleDateFormat("y");
        Date fecha = new Date(_fecha.getTime());
        return formato.format(fecha);
    }
    
}
