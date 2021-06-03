import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;

import org.aspectj.lang.reflect.MethodSignature;

import java.io.OutputStreamWriter;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;


public aspect Log{
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy MM dd HH:mm:ss");
    String fecha = format1.format(cal.getTime());
    
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* money*(..) );
    after() : success() {
        System.out.println("*** Transaccion realizada ***");
        FileOutputStream fos;
        String tipo = "";
        if(thisJoinPointStaticPart.getSignature().getName().equals("moneyMakeTransaction")) {
        	tipo = "Deposito";
        	}else if (thisJoinPointStaticPart.getSignature().getName().equals("moneyWithdrawal")) {
        	tipo = "Retiro";
        	 }
        
        try {
            fos = new FileOutputStream(file, true);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
            bw.newLine();
            bw.write(fecha +" //" + "Tipo de transaccion: " +tipo);
            bw.close();
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }    	
    }

}

//MethodSignature signature = (MethodSignature) joinPoint.getSignature();
//Method method = signature.getMethod();