public class Cursor{
  private PImage cursorImage;
  private float xPos;
  private float yPos;
  private float constantYVel = 20;
  private float constantXVel = 20;
  
  public Cursor(float oX, float oY){
    xPos = oX;
    yPos = oY;
    cursorImage = loadImage("resources/cursor.png");
  }
  
  public void draw(){
    // do this if the position is not where I want it to be
    if (xPos > 500& yPos< 1200){
      xPos -= constantXVel;
      yPos += constantYVel;
    }
    
    image(cursorImage, xPos, yPos, cursorImage.width*1.5, cursorImage.height*1.5);
  
  }
  
}
