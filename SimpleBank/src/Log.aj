import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import org.aspectj.lang.JoinPoint;

public aspect Log {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    FileWriter writer = null;
    
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut successTransaccion() : call(* money*(..) );
    
    after() : successTransaccion() {
    	try {
    		String Name = thisJoinPoint.getSignature().getName();
    		writer = new FileWriter(file, true); 
    		if( Name.equals("moneyMakeTransaction")) {
    			System.out.println("**** Transaccion Realizada ****");
    			writer.write("[ Tipo: Transaccion | Fecha: " + cal.getTime() + " ] \n");
    			writer.flush();
        		writer.close();
    		} else {
    			System.out.println("**** Retiro Realizado ****");
    			writer.write("[ Tipo: Retiro | Fecha: " + cal.getTime() + " ] \n");
    			writer.flush();
        		writer.close();
    		}
    	} catch(IOException ex) {
    		ex.printStackTrace();
    	}
    	
    }
}