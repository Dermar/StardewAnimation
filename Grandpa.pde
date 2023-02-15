import javafx.geometry.Point2D;
import java.io.*;

public class Grandpa{
  private PImage sprite;
  private PImage limbSprite;// used for arms and legs
  public List<ArrayList<Point2D>> frameMoves = new ArrayList<ArrayList<Point2D>>();
  private PaPart leftArm = new PaPart();
  private PaPart rightArm = new PaPart();
  private PaPart body = new PaPart();
  private PaPart leftLeg = new PaPart();
  private PaPart rightLeg = new PaPart();
  private int counter = 0;
  private float xOffset = 400;
  
  private Player player;
  
  public Grandpa(Player player){
    this.player = player;
    sprite = loadImage("resources/grandpa.png");
    limbSprite = loadImage("resources/statue.png");
    String[] frames = loadStrings("resources/monkey_moves.txt");
    
    // Look over every line in monkey_moves.txt, each line is the position of grandpa's limbs in a single frame
    for (int i = 0; i < frames.length; i++){
        String[] line = frames[i].split(", "); 
         
        // Parse and order grandpa's limbs
        ArrayList<Point2D> thisFrame = new ArrayList<Point2D>();
        for (int k = 1; k < line.length; k++){
          String[] point = line[k].split(" ");
          
          Point2D singlePoint = new Point2D(Double.parseDouble(point[0]) + xOffset, Double.parseDouble(point[1]));
          thisFrame.add(singlePoint);
        }
        
         frameMoves.add(thisFrame);
         
    
    }
    
    // Set initial positions of grandpa 
    leftArm.move(frameMoves.get(0).get(0).getX(), frameMoves.get(0).get(0).getY());
    rightArm.move(frameMoves.get(0).get(1).getX(), frameMoves.get(0).get(1).getY());
    body.move(frameMoves.get(0).get(2).getX(), frameMoves.get(0).get(2).getY());
    leftLeg.move(frameMoves.get(0).get(3).getX(), frameMoves.get(0).get(3).getY());
    rightLeg.move(frameMoves.get(0).get(4).getX(), frameMoves.get(0).get(4).getY());
  }
 
  
  public void draw(){
    if (counter >= 956){
      System.out.println("reset");
      counter = 0;
    }
    // Pair the different body parts to the point in frameMoves that is closest to their current position.
    List<Point2D> points = frameMoves.get(counter);
    List<Point2D> copyPoints = new ArrayList<Point2D>();
    for (Point2D position: points){
      copyPoints.add(position);
    }
    List<PaPart> unassigned = new ArrayList<PaPart>(){{
      add(leftArm);
      add(rightArm);
      add(body);
      add(rightLeg);
      add(leftLeg);
      
    }};
    
    for (int i = 0; i < points.size(); i++){
      Point2D point = points.get(i);
      Point2D min = new Point2D(30000, 30000);
      PaPart assigned = new PaPart();
      // Find the body part that is closest to this point so we can assign it to it
      for (PaPart part: unassigned){
        if (part.getPos().distance(point) < min.distance(point)){
          min = part.getPos();
          assigned = part;
          part.move(point.getX(), point.getY());
        }
      }
      
      unassigned.remove(assigned);
      
      for(PaPart toReset: unassigned){
        toReset.resetPos();
      }
      
      
    }
   
    // draw the arms, legs, and body
    image(limbSprite, (float)leftArm.getX(), (float)leftArm.getY(), limbSprite.width /1.5, limbSprite.height/1.5);
    image(limbSprite, (float)rightArm.getX(), (float)rightArm.getY(), limbSprite.width /1.5, limbSprite.height/1.5);
    image(sprite, (float)body.getX(), (float)body.getY(), sprite.width/1.5, sprite.height/1.5);
    image(limbSprite, (float)leftLeg.getX(), (float)leftLeg.getY(), limbSprite.width /1.5, limbSprite.height/1.5);
    image(limbSprite, (float)rightLeg.getX(), (float)rightLeg.getY(), limbSprite.width /1.5, limbSprite.height/1.5);
    
    counter++;
  
  }
  
  
  public boolean playerCollided(){
    return (hasCollided(leftArm) || hasCollided(rightArm) || hasCollided(leftLeg) || hasCollided(rightLeg));
  }
  
  public boolean hasCollided(PaPart paPart){// If one image is on left side of other then they're definitely not collided
    if (paPart.getX()> player.getXPos() + player.getImage().width/1.5 || player.getXPos() > paPart.getX() + sprite.width/1.5)
        return false;
 
    // If one rectangle is above the other
    if (paPart.getY() + sprite.height/1.5 > player.getYPos() || player.getYPos() + player.getImage().height/1.5 > paPart.getY())
        return false;
 
    return true;
    
  }   
  
  
}
