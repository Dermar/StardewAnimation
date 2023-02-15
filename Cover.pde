public class Cover{
  private Player toDetect;
  private PImage cover;
  private float xPos;
  private float yPos;
  
  
  public Cover(Player toDetect){
    this.toDetect = toDetect;
    cover = loadImage("resources/cover.png");
    xPos = 2000;
    yPos = 1200;
  }
  
  // Checks if the player is under the cover
  public boolean isFilled(){
    return toDetect.getXPos() >= xPos && toDetect.getYPos() >= 350;  

}
  
  public void draw(){
    image(cover, xPos, yPos, cover.width*2.9, cover.height*4.1);
  }
  
  
}
