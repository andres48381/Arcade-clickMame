boolean adjust_sound(char command)
{
  if(command=='i')
  {
    sound_level+=5;
   // launch("D:/Desarrollos/SoundVolumeView.exe /Unmute Altavoces ");  
    println("increase sound");
  }
  else if(command=='o')
  {
    sound_level-=5;
    println("decrease sound");
  }
  else
  {
    return false;
  }
  
  if(sound_level<0) sound_level=0;
  else if(sound_level>100) sound_level=100;
  
  println("sound_level: "+sound_level);
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
  
  return true;
}
void initMusic()
{
  fileA = new SoundFile(this, sounds_path+"A.mp3");
  fileB = new SoundFile(this, sounds_path+"B.mp3");
  fileI = new SoundFile(this, sounds_path+"I.mp3");
  
  launch(volume_path+" /SetVolume Altavoces "+str(sound_level));  
}
void playAmbientMusic()
{
  s=fileA;
  
  if(!s.isPlaying() && game_active.equals("NONE"))
  {
    s.play();
    println("***PLAYING MUSIC AMBIENT***");
  }
  else if(!game_active.equals("NONE") && s.isPlaying())
  {
    stopAmbientMusic();
  }
}
void stopAmbientMusic()
{
  s.stop();
  println("***STOP MUSIC AMBIENT***");    
}
