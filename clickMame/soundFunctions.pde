/**
  * @brief Regulador de volumen
  * @param command indicador de subida/bajada
  * @return resultado de la regulacion
  */
boolean adjust_sound(char command)
{
  if(command=='i')
  {
    sound_level+=10;
  }
  else if(command=='o')
  {
    sound_level-=10;
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
    myPort.write('S'); 
    myPort.write(sound_level); 
  }  
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
  
  return true;
}
/**
  * @brief
  * @param 
  * @return 
  */
void initMusic()
{
  fileA = new SoundFile(this, sounds_path+"A.wav");
  fileB = new SoundFile(this, sounds_path+"B.wav");
  fileI = new SoundFile(this, sounds_path+"I.wav");
  
  fileStart = new SoundFile(this, sounds_path+"start.wav");
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
}
/**
  * @brief
  * @param 
  * @return 
  */
void playStart()
{
  fileStart.play();
}
/**
  * @brief
  * @param 
  * @return 
  */
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

      playing_ambient=true;
      println("***PLAYING MUSIC AMBIENT***");
    }
    else if(playing_ambient && !s.isPlaying() && play_sound)
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
/**
  * @brief
  * @param 
  * @return 
  */
void stopAmbientMusic()
{
  s.stop();
  playing_ambient=false;
  println("***STOP MUSIC AMBIENT***");    
}
