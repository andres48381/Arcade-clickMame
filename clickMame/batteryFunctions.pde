 void launchBattScript()
 {
    Runtime r = Runtime.getRuntime();
    Process p1;
    try {
      p1 = r.exec("cmd /c start "+batt_script); //Lanza acceso directo con ejecucion minimizada
     println("***BATTERY SCRIPT LAUNCHED***");
    }
    catch(Exception c) {
      
           println("***BATTERY SCRIPT LAUNCHED ERROR***");
    }
 }
 
 void checkBattery()
 {
     //Battery (each 15seg)
    if(cont_battery>300)
    {
      lines_battery = loadStrings(batt_file);
      if(lines_battery!=null)
      {
        String[] battery_info;
        battery_info = split(lines_battery[0], ',');
        battery_state = (battery_info[0]).equals("Charging")?"1":"0";
        battery_level = int(battery_info[1])/10; 
        
        println(battery_state + ", " + battery_level);
        //Send start buttons
        if(myPort!=null)
        {   
          message="b/"+str(battery_level)+"/"+battery_state;
          myPort.write(message); //Envia codigo juego pulsado 
          println(message);
         // myPort.write(battery_level); //Envia codigo juego pulsado
        }  
        cont_battery=0;
      }
    }
    
    cont_battery+=1;
  }
