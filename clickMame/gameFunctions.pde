
/**
  * @brief
  * @param 
  * @return 
  */
void ctrlGames(char g)
{  
  playStart();
      
  //Send start buttons
  if(myPort!=null)
  {   
    message=g+"/1";
    myPort.write('J'); //Envia codigo juego pulsado
    myPort.write(g); //Envia codigo juego pulsado
    println(message);
  }  
  
  //Check game started
  if(!game_active.equals("NONE"))
  {       
      if(game_active.equals("MARIO"))
      {
        //Mario
        closeMario();
      }
      else if(game_active.equals("RAYMAN"))
      {
        //Rayman
        closeRayman();
      }
      else
      {
        //mame
        closeMameGame();
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
          delay(10000);
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
      
    //RAYMAN
    case 'r':
      if(!game_active.equals("RAYMAN"))
      {
         if(MAME_active)
         {
           closeMAME();
           MAME_active=false; 
         }
       
        launchRayman();
        game_active="RAYMAN";
      }
      else
      {
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
          delay(12000);
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
/**
  * @brief Lanza rom PANG
  * @param 
  * @return 
  */
void launchPang() 
{
  stopAmbientMusic();

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
/**
  * @brief Lanza Rayman
  * @param 
  * @return 
  */
void launchRayman() 
{
  stopAmbientMusic();

  //Lanzar Rayman
  robot.mouseMove(rayman_launch[0],rayman_launch[1]);
  mouseClick(true);
  
  delay(5000);
  
  //MAX Window
  robot.mouseMove(rayman_max[0],rayman_max[1]);
  mouseClick(false);
  
  //Ocultar
  robot.mouseMove(0,0);  
  robot.waitForIdle();  
}
/**
  * @brief Lanza rom Marvel
  * @param 
  * @return 
  */
void launchMarvel() 
{
  stopAmbientMusic();
  //Lanzar MARVEL
  robot.mouseMove(capcom_rom[0], capcom_rom[1]);
  mouseClick(true);
  
  delay(28000);
  
  //MAX Window
  robot.mouseMove(capcom_max[0], capcom_max[1]);
  mouseClick(false);
  
  //Ocultar
  robot.mouseMove(0,0);   
}
/**
  * @brief Lanza Mario
  * @param 
  * @return 
  */
void launchMario() 
{
  stopAmbientMusic();
  println("launchMario");
  robot.mouseMove(mario_launch[0],mario_launch[1]);
  println(mario_launch[0]+","+mario_launch[1]);
  mouseClick(true);  
  delay(5000);
  robot.mouseMove(mario_alert[0],mario_alert[1]);
  mouseClick(false);
  robot.waitForIdle();
}
/**
  * @brief Lanza aplicacion MAME
  * @param 
  * @return 
  */
void launchMAME()
{
  robot.mouseMove(mame_launch[0],mame_launch[1]);
  mouseClick(true);
  delay(5000);
  //robot.mouseMove(mame_alert[0],mame_alert[1]);
  //mouseClick(false);
  robot.keyPress(VK_ENTER);
  robot.keyRelease(VK_ENTER);
  robot.waitForIdle();
}
/**
  * @brief cierra aplicacion MAME
  * @param 
  * @return 
  */
void closeMAME()
{
  robot.mouseMove(close_mame[0], close_mame[1]);
  mouseClick(false);
  robot.waitForIdle();
  delay(3000);
}
/**
  * @brief pulsacion con boton izq raton
  * @param 
  * @return 
  */
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
/**
  * @brief Close rayman window
  * @param 
  * @return 
  */
void closeRayman()
{
  robot.mouseMove(1900, 0);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);

  //Close METAL SLUG
  //robot.mousePress(VK_ESCAPE);
  //robot.mouseRelease(VK_ESCAPE);

  robot.waitForIdle();
}
/**
  * @brief Close MAME window
  * @param 
  * @return 
  */
void closeMameGame()
{
  robot.mouseMove(1900, 0);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
}
/**
  * @brief Close Mario window
  * @param 
  * @return 
  */
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
