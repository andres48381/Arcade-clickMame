boolean adjust_sound(char command)
{
  if(command=='i')
  {
    sound_level+=10;
   // launch("D:/Desarrollos/SoundVolumeView.exe /Unmute Altavoces ");  
    //println("increase sound");
  }
  else if(command=='o')
  {
    sound_level-=10;
    //println("decrease sound");
  }
  else
  {
    return false;
  }
  
  if(sound_level<0) sound_level=0;
  else if(sound_level>100) sound_level=100;
  
  println("sound_level: "+sound_level);
  
  if(myPort!=null)
  {   
    message="S/"+str(sound_level);
    
    myPort.write('S'); 
    myPort.write(sound_level); 
  }  
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
  
  return true;
}
void initMusic()
{
  fileA = new SoundFile(this, sounds_path+"A.wav");
  fileB = new SoundFile(this, sounds_path+"B.wav");
  fileI = new SoundFile(this, sounds_path+"I.wav");
  
  fileStart = new SoundFile(this, sounds_path+"start.wav");
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
}
void playStart()
{
  fileStart.play();
}
void playAmbientMusic()
{
  
  if(game_active.equals("NONE"))
  {
    //Set Sound File
    if(!playing_ambient)
    {
      int num_sound=int(random(3));
      
      switch(num_sound)
      {
        case 0:  s=fileA; break;
        case 1: s=fileB; break;
        case 2: s=fileI; break;
        default:  s=fileA; break;  
      }    
      
      //s.play();
      playing_ambient=true;
      println("***PLAYING MUSIC AMBIENT***");
    }
    else if(playing_ambient && !s.isPlaying())
    {
      //Play Sound File
      s.play();
      println("***PLAYING MUSIC AMBIENT***");
    }  
  }
  else if(!game_active.equals("NONE") && s.isPlaying())
  {
    stopAmbientMusic();
  }
}
void stopAmbientMusic()
{
  s.stop();
  playing_ambient=false;
  println("***STOP MUSIC AMBIENT***");    
}
