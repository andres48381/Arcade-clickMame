 
/**
  * @brief 
  * @return 
  */
void setup() {
  
  //Frame size
  size(320, 120); 
  stroke(255);
  noFill();
  delay(15000);

  //Sound files initialized
  initMusic();

  //Robot para pulsaciones fantasma
  try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  pfont = createFont("Impact", 32);

  //Conexion serie Arduino
  if(Serial.list().length>0)
  {
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
  }
      
  //Get game coordenates from file
  readConfFile();  
    
  //Send start button board
  if(myPort!=null)
  {   
    message="A/1";
    myPort.write(message); //Envia "A/1" para que el Arduino abandone estado de espera
    println(message);
  }  

  //Lanza bucle de gestion de bateria
  launchBattScript();
  //Get battery state/load and update display
  checkBattery();

  delay(3000);

  //Sonido
  if(myPort!=null)
  {  
    myPort.write('S'); 
    myPort.write(sound_level); 
  }
    
  robot.mouseMove(app_min[0],app_min[1]);
  mouseClick(false);  
}
/**
  * @brief 
  * @return 
  */ 
void draw() {
  
  //Window
  background(#ffffff);
  fill(#000000);
  
  //Show cursos coordenates
  if(show_coord){
    printCoordenates();
  }

  //Comunicacion botonera games
  if(myPort!=null)
  {
    if ( myPort.available() > 0) 
      {  
        // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
        if(val!=null)
        {
          println(val); //print it out in the console
          char code=val.charAt(0);
                  
           //Check comando de sonido
          if(!adjust_sound(code))
          {
            //Controla estado de iniciar/parar juegos
            ctrlGames(code);
          }
        } 
      }
  }
   
   //Get battery state/load and update display
  checkBattery();
  
  //Ambient play music control.
  playAmbientMusic();
  
  delay(150);
}
/**
  * @brief 
  * @return 
  */
void keyPressed() 
{
   //Check comando de sonido
  if(!adjust_sound(key))
  {
    //Lanza juego recibido
    ctrlGames(key);
  }   
}
