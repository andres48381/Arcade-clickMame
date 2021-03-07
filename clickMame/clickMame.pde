import processing.serial.*;

//
//  how to use java.awt.Robot class in processing ...
//
import java.awt.*;
import java.awt.event.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

Robot robot;
PFont pfont;
Point save_p;
 
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
  
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}
 
void draw() {
  background(#ffffff);
  fill(#000000);
  
  Point p = getGlobalMouseLocation();
  
  textFont(pfont);
  text("now x=" + (int)p.getX() + ", y=" + (int)p.getY(), 10, 32);
  
  if (save_p != null) {
  text("save x=" + (int)save_p.getX() + ", y=" + (int)save_p.getY(), 10, 64);
  }
  
    if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
    println(val); //print it out in the console
    
    if(val!=null) startGame(val.charAt(0));
  } 

}

void keyPressed() {

  startGame(key);
}

void startGame(char k)
{
  switch(k) {
  case 's':
    save_p = getGlobalMouseLocation();
    break;
  case 'm':
    if (save_p != null) {
      mouseMove((int)save_p.getX(), (int)save_p.getY());
    }
    break;
  case 'c':
    close();
    break;
  
  case ' ':
    if (save_p != null) {
      mouseMoveAndClick((int)save_p.getX(), (int)save_p.getY());
    }
    break;
    
   case 'p':
     launchPang();
     break;
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

void launchPang() {
  //pang 714,218
//pang max 1073,391
//ghost 874,305
  
  robot.mouseMove(850, 284);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  
  delay(1000);
    robot.mouseMove(1073, 391);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    robot.mouseMove(0,0);
  
  robot.waitForIdle();
}

void close()
{
    robot.mouseMove(1900, 0);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    robot.waitForIdle();
}
