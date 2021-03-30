
//Libraries
import processing.serial.*;
import java.awt.*;
import java.awt.event.*;
import static java.awt.event.KeyEvent.*;
  
import processing.sound.*;

String version= "0.1.0";

//Comunicacion botonera games
Serial myPort=null;  // Create object from Serial class
String val;     // Data received from the serial port
String message="";

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

//Sound
int sound_level=8;
SoundFile s; //Puntero de control
SoundFile fileA,fileB,fileI,fileStart;

//Paths
String coord_file="C:\\RetroGameMarcos\\positions.txt";
String batt_file = "C:\\RetroGameMarcos\\battery.txt";
String batt_script = "C:/RetroGameMarcos/getBattery";
String sounds_path = "C:/RetroGameMarcos/sounds/";
String volume_path = "C:/RetroGameMarcos/SoundVolumeView.exe";
