
//Libraries
import processing.serial.*;
import java.awt.*;
import java.awt.event.*;
import static java.awt.event.KeyEvent.*;

//Comunicacion botonera games
Serial myPort=null;  // Create object from Serial class
String val;     // Data received from the serial port

//Control de cursor
Robot robot;
PFont pfont;
Point save_p;

//Maquina estado juegos
String game_active="NONE";
boolean MAME_active=false;

//Coordeandas
int mario_launch[]={430, 43};
int mame_launch[]={530, 43};
int mame_alert[]={1032, 650};
int kill_mario[]={330, 30};
int pang_rom[]={350,304};
int capcom_rom[]={440,304};
int bubble_rom[]={730,400};
int close_rom_window[]={1900,0};
int close_mame[]={1190, 215};
int pang_max[]={1073,391};
int capcom_max[]={1073,411};
int bubble_max[]={1050, 405};


void setup() {
  
  size(320, 240);
  
  
  try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  pfont = createFont("Impact", 32);
  
  //Conexion botonera games
  //TODO Excepcion si no hay arduino
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
}
 
void draw() {
  
  //Window
  background(#ffffff);
  fill(#000000);
  
  //Get coordenates cursor
  Point p = getGlobalMouseLocation();  
  textFont(pfont);
  text("now x=" + (int)p.getX() + ", y=" + (int)p.getY(), 10, 32);  
  if (save_p != null) {
  text("save x=" + (int)save_p.getX() + ", y=" + (int)save_p.getY(), 10, 64);
  }
  
  //Comunicacion botonera games
  if(myPort!=null)
  {
      if ( myPort.available() > 0) 
      {  
        // If data is available,
        val = myPort.readStringUntil('\n');         // read it and store it in val
        println(val); //print it out in the console
        
        //Lanza juego recibido
        if(val!=null)
        {
          startGame(val.charAt(0));
        } 
      }
  }
}

void keyPressed() {

  startGame(key);
}

void startGame(char g)
{
  
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
      
      delay(1000);
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
          delay(1000);
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
          delay(1000);
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
          delay(1000);
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
                
    /*
    case 's':
      save_p = getGlobalMouseLocation();
      break;
    case 'm':
      if (save_p != null) {
        mouseMove((int)save_p.getX(), (int)save_p.getY());
      }
      break;
    
    case ' ':
      if (save_p != null) {
        mouseMoveAndClick((int)save_p.getX(), (int)save_p.getY());
      }
      break;
        */
  }
}

Point getGlobalMouseLocation() {
  // java.awt.MouseInfo
  PointerInfo pointerInfo = MouseInfo.getPointerInfo();
  Point p = pointerInfo.getLocation();
  return p;  
}

void mouseMove(int x, int y) {
  robot.mouseMove(x, y);
}

void mouseMoveAndClick(int x, int y) {
  robot.mouseMove(x, y);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
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
  
  delay(1000);
  
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
  robot.mouseMove(730,400);
  mouseClick(true);
  
  delay(1000);
  
  //MAX Window
  robot.mouseMove(1050, 405);
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
  
  delay(3000);
  
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
  robot.mouseMove(430, 43);
  mouseClick(true);  
  robot.waitForIdle();
}
//Lanza aplicacion MAME
void launchMAME()
{
  robot.mouseMove(mame_launch[0],mame_launch[1]);
  mouseClick(true);
  delay(1000);
  robot.mouseMove(mame_alert[0],mame_alert[1]);
  mouseClick(false);
  robot.waitForIdle();
}

void closeMAME()
{
  robot.mouseMove(close_mame[0], close_mame[1]);
  mouseClick(false);
  robot.waitForIdle();
  delay(1000);
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
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.keyPress(VK_WINDOWS);
  robot.keyRelease(VK_WINDOWS);
  delay(4000);
  robot.mouseMove(kill_mario[0],kill_mario[1]);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
}
