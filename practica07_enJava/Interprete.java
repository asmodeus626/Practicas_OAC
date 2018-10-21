

import java.util.Scanner;
import java.io.FileReader;
import java.io.BufferedReader;

public class Interprete{

	public Interprete(){}

	public String reversa(String cadena){
		String retVal = "";

		for(int i=cadena.length()-1;i>=0;i--){
			retVal+=cadena.charAt(i);
		}

		return retVal;
	}

	public void help(String[] arg){
		if(arg.length==1){
			System.out.println("Comandos disponibles:\nrev\ncat\nexit");
		}else{
			switch(arg[1]){
				case "rev" : System.out.println("Imprime la reversa de una cadena.");
				             System.out.println("Si recibe el nombre de un archivo aplica la función sobre el contenido de este");
				             System.out.println("Si se ejecuta sin argumentos se aplica sobre la siguiente línea");
				break;
				case "cat" : System.out.println("Concatena los archivos que recibe como argumentos");
				break;
				case "exit": System.out.println("Sale del programa");
				break;
				default: System.out.println("Comando no encontrado");
				break;
			}
		}
	}

	public void rev(String[] arg){
		if(arg.length==1){
			System.out.println("Escriba una cadena");
			Scanner scan = new Scanner(System.in);
			String ent = scan.nextLine();
			System.out.println(reversa(ent));
		}else{
			try{
            	FileReader fr1 = new FileReader(arg[1]);
            	BufferedReader br1 = new BufferedReader(fr1);
            	String salida = "";
            	String linea = br1.readLine();
            
            	while(linea!=null){
            		salida+=linea+"\n";
                	linea = br1.readLine();
            	}

            	System.out.println(reversa(salida));
        	}catch(Exception ex){System.out.println("Archivo no encontrado :'v");}
		}
	}

	public void cat(String[] arg){
		if(arg.length==1){
			System.out.println("No tiene argumentos :'v");
		}else{
			String salida = "";
			for(int i=1;i<arg.length;i++){
				try{
            	FileReader fr1 = new FileReader(arg[i]);
            	BufferedReader br1 = new BufferedReader(fr1);
            	String linea = br1.readLine();
            
            	while(linea!=null){
            		salida+=linea+"\n";
                	linea = br1.readLine();
            	}

        		}catch(Exception ex){System.out.println("Archivo no encontrado :'v");}
			}
			System.out.println(salida);
		}
	}

	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		Interprete interp = new Interprete();
		String entrada = "";
		while(!entrada.equals("exit")){
			System.out.println("Ejecute un comando");
			entrada = sc.nextLine();
			String[] comando = entrada.split(" "); //Separa la cadena por espacios

			switch(comando[0]){
				case "help" : interp.help(comando);
				break;
				case "rev" : interp.rev(comando);
				break;
				case "cat" : interp.cat(comando);
				break;
				case "exit": break;
				default: System.out.println("Comando no encontrado");
				break;
			}
		}
	}
}
