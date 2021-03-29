boolean adjust_sound(char command)
{
  if(command=='i')
  {
    sound_level+=10;
    launch("D:/Desarrollos/SoundVolumeView.exe /Unmute Altavoces ");  
    println("increase sound");
  }
  else if(command=='o')
  {
    sound_level-=10;
    println("decrease sound");
  }
  else
  {
    return false;
  }
  
  if(sound_level<0) sound_level=0;
  else if(sound_level>100) sound_level=100;
  
  launch("D:/Desarrollos/SoundVolumeView.exe /SetVolume Altavoces "+str(sound_level));  
  
  return true;
}
void playMusic()
{
  file = new SoundFile(this, sounds_path+"B.mp3");
  file.play();
}
