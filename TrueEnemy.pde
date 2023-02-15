public class TrueEnemy{  
  private PImage sprite;
  private float xPos;
  private float yPos;
  private float xVel;
  private float yVel;
  private boolean hasChangedDirection; 
  private int speed = 4;
  private Player player;
  
  public TrueEnemy(Player player){
    sprite = loadImage("resources/true_statue.png");
    xPos = 1300;
    yPos = 700;
    this.player = player;
    
    Random rand = new Random();
    xVel = -rand.nextFloat()*speed;
    int multiplier = rand.nextInt(2);
    if (multiplier == 1){
      multiplier = -1;
    }
    else{
      multiplier = 1;
    }
    
    yVel = rand.nextFloat() * speed * multiplier;
    hasChangedDirection = true;
    
  }
  
  public void draw(){
      
    if (!hasChangedDirection){
      // Change its direction if it's hit an edge
      Random rand = new Random();
      int multiplier = rand.nextInt(2);
      if (multiplier == 0){
        multiplier = 1;
      }
      else{
        multiplier = -1;
      }
      
      if (xPos == width - sprite.width){
        xVel = -rand.nextFloat() * speed;
        yVel = rand.nextFloat() * speed * multiplier;
      }
      if (xPos == 0){
        xVel = rand.nextFloat()*speed;
        yVel = rand.nextFloat() * speed * multiplier;
      }
      if (yPos == 0){
        yVel = rand.nextFloat() * speed;
        xVel = rand.nextFloat()*speed * multiplier;
      }
      if (yPos == height - sprite.height){
        yVel = -rand.nextFloat() * speed;
        xVel = rand.nextFloat()*speed * multiplier;
      }
      hasChangedDirection = true;
      
    }
    xPos += xVel;
    yPos += yVel;
    
    // Apply game edges
    if (xPos + sprite.width > width){
      xPos = width - sprite.width;
      hasChangedDirection = false;
    }
    if (xPos < 0){
      xPos = 0;
      hasChangedDirection = false;
    }
    if (yPos < 0){
      yPos = 0;
      hasChangedDirection = false;
    }
    if (yPos + sprite.height > height){
      yPos = height - sprite.height;
      hasChangedDirection = false;
    }
    
    image(sprite, xPos, yPos, sprite.width/2.5, sprite.height/2.5);
    
  }
  
  
  public boolean hasCollided(){// If one image is on left side of other then they're definitely not collided
    if (xPos > player.getXPos() + player.getImage().width/2.5 || player.getXPos() > xPos + sprite.width/2.5)
        return false;
 
    // If one rectangle is above the other
    if (yPos + sprite.height/2.5 > player.getYPos() || player.getYPos() + player.getImage().height/2.5 > yPos)
        return false;
 
    return true;
    
  }   
}
