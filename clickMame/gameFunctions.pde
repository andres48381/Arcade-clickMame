
void ctrlGames(char g)
{  
  //Send start buttons
  if(myPort!=null)
  {   
    message=g+"/1";
    myPort.write(message); //Envia codigo juego pulsado
    println(message);
  }  
  
  //Check game started
  if(!game_active.equals("NONE"))
  {       
      if(!game_active.equals("MARIO"))
      {
        closeMameGame();
      }
      else
      {
        //Mario
        closeMario();
      }  
      
      delay(3000);
  }  

  
  switch(g) 
  {
    //PANG
    case 'p':
      if(!game_active.equals("PANG"))
      {
        if(!MAME_active)
        {
          launchMAME();
          MAME_active=true;
          delay(6000);
        }
        
        launchPang();
        game_active="PANG";
      }
      else
      {
        closeMAME();
        MAME_active=false;      
        game_active="NONE";
      }
      break;
      
    //BUBBLE 2
    case 'b':
      if(!game_active.equals("BUBBLE"))
      {
        if(!MAME_active)
        {
          launchMAME();
          MAME_active=true;
          delay(3000);
        }
        
        launchBubble();
        game_active="BUBBLE";
      }
      else
      {
        closeMAME();
        MAME_active=false;     
        game_active="NONE";
      }
      break;
    
    //CAPCOM MARVEL
    case 'c':
      if(!game_active.equals("MARVEL"))
      {        
        if(!MAME_active)
        {
          launchMAME();
          MAME_active=true;
          delay(3000);
        } 
        
        launchMarvel();
        game_active="MARVEL";
      }
      else
      {
        closeMAME();
        MAME_active=false;
        game_active="NONE";
      }
      break;
    
    //SUPER MARIO
    case 'm':
      if(!game_active.equals("MARIO"))
      {
         if(MAME_active)
         {
           closeMAME();
           MAME_active=false; 
         }
       
        launchMario();
        game_active="MARIO";
      }
      else
      {
        game_active="NONE";
      }
      break;
      
     case 'x':
      launchMAME();
      break;     
               
  }  
   //Check game started
  if(myPort!=null)
  {
    message=game_active+"/1";
    myPort.write(message); //Envia codigo juego iniciado 
    println(message);
  }
}

//Lanza rom PANG
void launchPang() 
{
  //pang 714,218
//pang max 1073,391
//ghost 874,305
  
  //Lanzar PANG
  robot.mouseMove(pang_rom[0], pang_rom[1]);
  mouseClick(true);
  
  delay(6000);
  
  //MAX Window
  robot.mouseMove(pang_max[0], pang_max[1]);
  mouseClick(false);
  
  //Ocultar
  robot.mouseMove(0,0);  
  robot.waitForIdle();
}
//Lanza rom Bubble
void launchBubble() 
{
  //Lanzar BUBBLE
  robot.mouseMove(bubble_rom[0],bubble_rom[1]);
  mouseClick(true);
  
  delay(8000);
  
  //MAX Window
  robot.mouseMove(bubble_max[0],bubble_max[1]);
  mouseClick(false);
  
  //Ocultar
  robot.mouseMove(0,0);  
  robot.waitForIdle();  
}
//Lanza rom Marvel
void launchMarvel() 
{
  //Lanzar MARVEL
  robot.mouseMove(capcom_rom[0], capcom_rom[1]);
  mouseClick(true);
  
  delay(10000);
  
  //MAX Window
  robot.mouseMove(capcom_max[0], capcom_max[1]);
  mouseClick(false);
  
  //Ocultar
  robot.mouseMove(0,0);   
}
//Lanza rom Mario
void launchMario() 
{
  println("launchMario");
  robot.mouseMove(mario_launch[0],mario_launch[1]);
  println(mario_launch[0]+","+mario_launch[1]);
  mouseClick(true);  
  delay(5000);
  robot.mouseMove(mario_alert[0],mario_alert[1]);
  mouseClick(false);
  robot.waitForIdle();
}
//Lanza aplicacion MAME
void launchMAME()
{
  robot.mouseMove(mame_launch[0],mame_launch[1]);
  mouseClick(true);
  delay(5000);
  robot.mouseMove(mame_alert[0],mame_alert[1]);
  mouseClick(false);
  robot.waitForIdle();
}

void closeMAME()
{
  robot.mouseMove(close_mame[0], close_mame[1]);
  mouseClick(false);
  robot.waitForIdle();
  delay(3000);
}

//Doble pulsacion con boton izq
void mouseClick(boolean doble)
{
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  if(doble)
  {
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
    robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  }
}

//Close max windows
void closeMameGame()
{
  robot.mouseMove(1900, 0);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
}

//Close Mario emulator with .bat
void closeMario()
{
  robot.mouseMove(1000, 300);
  mouseClick(false);
  robot.keyPress(VK_WINDOWS);
  robot.keyRelease(VK_WINDOWS);
  robot.waitForIdle();
  delay(7000);
  robot.mouseMove(kill_mario[0],kill_mario[1]);
  mouseClick(true);
}
