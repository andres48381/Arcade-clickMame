boolean readConfFile()
{
  
    lines = loadStrings(coord_file);
  
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
      rayman_launch[0] = int(pieces[0]);
      rayman_launch[1] = int(pieces[1]);   
      
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
      rayman_max[0] = int(pieces[0]);
      rayman_max[1] = int(pieces[1]);         
     // println(mario_launch[0]+","+mario_launch[1]);
     
     println("***CONF FILE READ***");
     
     return true;
    }  
    
  return false;
  
}
