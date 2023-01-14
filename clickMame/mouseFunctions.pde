
/**
  * @brief
  * @param 
  * @return 
  */
Point getGlobalMouseLocation() {
  PointerInfo pointerInfo = MouseInfo.getPointerInfo();
  Point p = pointerInfo.getLocation();
  return p;  
}
/**
  * @brief
  * @param 
  * @return 
  */
void mouseMove(int x, int y) {
  robot.mouseMove(x, y);
}
/**
  * @brief
  * @param 
  * @return 
  */
void mouseMoveAndClick(int x, int y) {
  robot.mouseMove(x, y);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
}
/**
  * @brief
  * @param 
  * @return 
  */
void printCoordenates()
{
  //Get coordenates cursor
  Point p = getGlobalMouseLocation();  
  textFont(pfont);
  text("now x=" + (int)p.getX() + ", y=" + (int)p.getY(), 10, 32);  
  if (save_p != null) {
    text("save x=" + (int)save_p.getX() + ", y=" + (int)save_p.getY(), 10, 64);
  }
}
