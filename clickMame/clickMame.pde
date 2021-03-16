
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
int mario_launch[]={0,0};
int mario_alert[]={0,0};
int mame_launch[]={0,0};
int mame_alert[]={0,0};
int kill_mario[]={0,0};
int pang_rom[]={0,0};
int capcom_rom[]={0,0};
int bubble_rom[]={0,0};
int close_rom_window[]={0,0};
int close_mame[]={0,0};
int pang_max[]={0,0};
int capcom_max[]={0,0};
int bubble_max[]={0,0};

//File input coordenates
String[] lines;
int index = 0;

//File input battery
String[] lines_battery;
String battery_state;
int battery_level;
int cont_battery=0;

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
  
  lines = loadStrings("C:\\positions.txt");
  
  lines_battery = loadStrings("D:\\battery.txt");

/*  while(index < lines.length) {
    String[] pieces = split(lines[index], ',');
    if (pieces.length == 2) {
      int x = int(pieces[0]);
      int y = int(pieces[1]);
      point(x, y);
    }
    // Go to the next line for the next run through draw()
    index = index + 1;*/
    if(lines!=null)
    {
      String[] pieces;
      pieces = split(lines[index++], ',');
      mario_launch[0] = int(pieces[0]);
      mario_launch[1] = int(pieces[1]); 
      
      pieces = split(lines[index++], ',');
      mario_alert[0] = int(pieces[0]);
      mario_alert[1] = int(pieces[1]);        
      
      pieces = split(lines[index++], ',');  
      mame_launch[0] = int(pieces[0]);
      mame_launch[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ',');
      mame_alert[0] = int(pieces[0]);
      mame_alert[1] = int(pieces[1]);  
      
      pieces = split(lines[index++], ','); 
      kill_mario[0] = int(pieces[0]);
      kill_mario[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ',');
      pang_rom[0] = int(pieces[0]);
      pang_rom[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ',');
      capcom_rom[0] = int(pieces[0]);
      capcom_rom[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ',');
      bubble_rom[0] = int(pieces[0]);
      bubble_rom[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ',');
      close_rom_window[0] = int(pieces[0]);
      close_rom_window[1] = int(pieces[1]);  
      
      pieces = split(lines[index++], ','); 
      close_mame[0] = int(pieces[0]);
      close_mame[1] = int(pieces[1]);  
      
      pieces = split(lines[index++], ',');  
      pang_max[0] = int(pieces[0]);
      pang_max[1] = int(pieces[1]);   
      
      pieces = split(lines[index++], ','); 
      capcom_max[0] = int(pieces[0]);
      capcom_max[1] = int(pieces[1]);  
      
      pieces = split(lines[index++], ',');  
      bubble_max[0] = int(pieces[0]);
      bubble_max[1] = int(pieces[1]);         
     // println(mario_launch[0]+","+mario_launch[1]);
    }  
    
    //Battery
    if(lines_battery!=null)
    {
      String[] battery_info;
      battery_info = split(lines_battery[0], ',');
      battery_state = (battery_info[0]);
      battery_level = int(battery_info[1]); 
      
      println(battery_state + ", " + battery_level);
    }
    
    
    //Send start buttons
  if(myPort!=null)
  {   
    myPort.write("A"); //Envia una "A" para que el Arduino encienda el led
  }  
}
 
void draw() {
  
  //Window
  background(#ffffff);
  fill(#000000);
  
  //Get coordenates cursor
 /* Point p = getGlobalMouseLocation();  
  textFont(pfont);
  text("now x=" + (int)p.getX() + ", y=" + (int)p.getY(), 10, 32);  
  if (save_p != null) {
  text("save x=" + (int)save_p.getX() + ", y=" + (int)save_p.getY(), 10, 64);
  }
*/
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
  
    //Battery
    if(cont_battery>300)
    {
      lines_battery = loadStrings("D:\\battery.txt");
      if(lines_battery!=null)
      {
        String[] battery_info;
        battery_info = split(lines_battery[0], ',');
        battery_state = (battery_info[0]);
        battery_level = int(battery_info[1]); 
        
        println(battery_state + ", " + battery_level);
        
        cont_battery=0;
      }
    }
    
    cont_battery+=1;
    delay(50);
}

void keyPressed() {

  startGame(key);
}

void startGame(char g)
{  
  //Send start buttons
  if(myPort!=null)
  {   
    myPort.write(g); //Envia codigo juego pulsado
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
     myPort.write(game_active); //Envia codigo juego iniciado 
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
