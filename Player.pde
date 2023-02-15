

public class Player{
  private float xPos = 2000;
  private float yPos = 1000;
  private PImage upStill;
  private PImage upRun;
  private PImage downStill;
  private PImage downRun;
  private PImage rightStill;
  private PImage rightRun;
  private PImage leftStill;
  private PImage leftRun;
  private PImage currImage;
  
  private String prevOrientation = "left";
  private boolean isMoving; 
  private float movementSpeed = 40;
  
  public Player(){
    upStill = loadImage("resources/forward_still.png");
    upRun = loadImage("resources/forward_run.png");
    downStill = loadImage("resources/back_still.png");
    downRun = loadImage("resources/back_run.png");
    rightStill = loadImage("resources/right_still.png");
    rightRun = loadImage("resources/right_run.png");
    leftStill = loadImage("resources/left_still.png");
    leftRun = loadImage("resources/left_run.png");
    
    currImage = leftStill;
    
  }
  
  public void draw(){
    if (isMoving){
      if (prevOrientation.equals("up")){
        yPos -= movementSpeed;
      }
      if (prevOrientation.equals("down")){
        yPos += movementSpeed;
      }
      if (prevOrientation.equals("right")){
        xPos += movementSpeed;
      }
      if (prevOrientation.equals("left")){
        xPos -= movementSpeed;
      }
    }
    image(currImage, xPos, yPos, currImage.width*1.4, currImage.height*1.4);
  
  }
  
  public void moveLeft(){
    prevOrientation = "left";
    xPos -= movementSpeed;
    currImage = leftRun;
    isMoving = true;
  }
  
  public void moveRight(){
    prevOrientation = "right";
    xPos += movementSpeed;
    currImage = rightRun;
    isMoving = true;
    
  }
  
  public void moveUp(){
    prevOrientation = "up";
    yPos -= movementSpeed;
    currImage = upRun;
    isMoving = true;
  }
  
  public void moveDown(){
    prevOrientation = "down";
    yPos += movementSpeed;
    currImage = downRun;
    isMoving = true;
  }
  
  public void stabiliseMovement(){
    if (prevOrientation.equals("up")){
      currImage = upStill;
    }
    if (prevOrientation.equals("down")){
      currImage = downStill;
    }
    if (prevOrientation.equals("right")){
      currImage = rightStill;
    }
    if (prevOrientation.equals("left")){
      currImage = leftStill;
    }
    isMoving = false;
  }
  
  public void setPos(float x, float y){
    xPos = x;
    yPos = y;
    prevOrientation = "left";
    currImage = leftStill;
  }
  
  public void setPosUp(){
    prevOrientation = "up";
    currImage = upStill;
  }
  
  public float getXPos(){return xPos;}
  public float getYPos(){return yPos;}
  public PImage getImage(){return currImage;}
  
}
