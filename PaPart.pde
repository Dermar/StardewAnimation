public class PaPart{
  private double xPos;
  private double yPos;
  private double prevXPos;
  private double prevYPos;
  private boolean isBody;
  
  
  public PaPart(double xPos, double yPos, boolean isBody){
    this.xPos = xPos;
    this.yPos = yPos;
    this.prevXPos = xPos;
    this.prevYPos = yPos;
    this.isBody = isBody;
  }
  public PaPart(){}
  
  public void move(double xPos, double yPos){
    prevXPos = this.xPos;
    prevYPos = this.yPos;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public Point2D getPos(){return new Point2D(xPos, yPos);}
  public double getX(){return xPos;}
  public double getY(){return yPos;}
  
  public void resetPos(){
    xPos = prevXPos;
    yPos = prevYPos;
  }


}
