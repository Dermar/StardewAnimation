import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 
import java.util.*;
import java.io.*;

private Cursor cursor;
private Grandpa pa;
private Player player;
private Cover cover;
private int slept;
private boolean hasSlept;
private int sleptSince;
private boolean shamedGrandpa;
private boolean angeredGrandpa;
private float oscillation = 2;
private boolean changeDir;
private PImage quote;
private TrueEnemy trueStat;
private int hitTimes;

public void setup(){
  fullScreen(P2D);
  player = new Player();
  pa = new Grandpa(player);
  trueStat = new TrueEnemy(player);
  quote = loadImage("resources/grandpa_1.png");
  
  cursor = new Cursor(width/2, height / 2);
  cover = new Cover(player);
  background(loadImage("resources/opening.jpg"));
  frameRate(30);
  
  
  
}

public void draw(){
  fill(255, 0, 0);
  
  // Monkey fight scene (remember to check frames) && frameCount > 130
  if (shamedGrandpa && angeredGrandpa && frameCount > 200){
    background(loadImage("resources/bg.png"));
    textSize(10);
    text("SID500557727_Asgmt2Opt1", 0, 40);
    player.draw();
    pa.draw();
    trueStat.draw();
    if (pa.playerCollided() || trueStat.hasCollided()){
      hitTimes++;
    }
    
    
    fill(255);
    textSize(30);
    text("Sanity Meter", 30, 90);
    if (hitTimes <= 40){
      fill(229, 247, 95);
      rect(30, 110, 800 - hitTimes*20, 30, 5);}
    else{
      fill(63, 90, 45);
      rect(30, 110, 100, 30, 5);}
  }
    
  
  // Introduce grandpa (he's the monkey marionette)
  else if (shamedGrandpa){
    background(loadImage("resources/bg.png"));
    text("SID500557727_Asgmt2Opt1", 0, 40);
    player.draw();
    PImage grandpa = loadImage("resources/grandpa.png");
    // logic to make grandpa hover in the air initially  
    if (frameCount % 10 == 0){
      changeDir = !changeDir;
    }
    if (changeDir){
      oscillation+=2;  
    }
    else{
      oscillation -=2;
    }
    
    if (frameCount >= 180){
      pa.draw();
      quote = loadImage("resources/grandpa_3.png");
      angeredGrandpa = true;
    }
    else if (frameCount >= 120){
      quote = loadImage("resources/grandpa_2.png");
      image(grandpa, width/2.25, height/4 + oscillation);
    }
    else if (frameCount >= 60){
      quote = loadImage("resources/grandpa_1.png");
      image(grandpa, width/2.25, height/4 + oscillation);
      
    }
    image(quote, width/3 - 50, height - 350);
    
  }
  
  // Days passing scene
  else if (frameCount >= 30){
    background(loadImage("resources/inside_bg.png"));
    text("SID500557727_Asgmt2Opt1", 0, 40);
    player.draw();
    cover.draw();
    
    PImage sleepQ = loadImage("resources/sleep.jpg"); 
    if (cover.isFilled() && !hasSlept){
      slept++;
      image(sleepQ, width/3 - 120 - slept*200, height - 200 - slept*250 , sleepQ.width * (slept*0.6+1), sleepQ.height * (slept*0.6 + 1));
      hasSlept = true;
      sleptSince++;
    }
    // Set a buffer time (5 frames) between getting into bed and waking up for the next day
    else if (hasSlept && sleptSince < 6){
      image(sleepQ, width/3 - 120 - slept*200, height - 200 - slept*250 , sleepQ.width * (slept*0.6+1), sleepQ.height * (slept*0.6 + 1));
      sleptSince++;
    }
    // Reset the player to a new day if they've slept
    else if (sleptSince >= 5){
      player.setPos(1400, 880);
      hasSlept = false;
      sleptSince = 0;
    }
    
    // If the player has slept three times in a row, surmise a 2 year sleeping spree and go to the scene where we introduce grandpa
    if (slept >= 3 && sleptSince >= 5){
      shamedGrandpa = true;
      player.setPos(width/2.25 + 20, height - 500);
      player.setPosUp();
    }
  }  
  
  
  // Opening scene
  else if (frameCount >= 0){
    background(loadImage("resources/opening.jpg"));
    text("SID500557727_Asgmt2Opt1", 0, 40);
    cursor.draw();
   
  }
 

}


public void keyPressed(){
  
    if (keyCode == UP) {
      player.moveUp();
    } 
    else if (keyCode == DOWN) {
      player.moveDown();
    } 
    else if (keyCode == RIGHT){
      player.moveRight();
    }
    else if (keyCode == LEFT){
      player.moveLeft();
    }
  
  }
  
public void keyReleased(){
  if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT){
    player.stabiliseMovement();
  }
}
