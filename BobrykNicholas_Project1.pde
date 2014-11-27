/**  Nicholas Bobryk
     Project 1
     CSC 220  */
     
     
boolean started;
int time;
int score;
int lives;
int highScore;
int prevScore;
int locX;
int locY;
int speed;

//arraylist to hold 5he enemies' info
ArrayList<Enemy> enemies = new ArrayList();

//array for keys pressed
boolean[] keys = {false, false, false, false};

void setup(){
  frameRate(60);
  started = false;
  smooth();
  size(500,500);
  score = 0;
  lives = 3;
  highScore = 0;
  time = 0;
  prevScore = 0;
  locX = width/2;
  locY = height/2;
  speed = 2;
}

void draw(){
  if(started){  
    //transluscent background
    noStroke(); 
    fill(255,255,255,70);
    rect(0,0,500,500);
    
    //movement of the player
    if(keys[0]){
      locY-=speed;
    }
    if(keys[1]){
      locY+=speed;
    }
    if(keys[2]){
      locX-=speed;
    }
    if(keys[3]){
      locX+=speed;
    }
    //boundaries for the player
    if(locX<10){
      locX=10;
    }
    if(locX>490){
      locX=490;
    }
    if(locY<10){
      locY=10;
    }
    if(locY>490){
      locY=490;
    }
    //draw the player
    ellipseMode(CENTER);
    fill(50,50,255);
    ellipse(locX,locY,20,20);
    
    //add an enemy every second
    if(time%60==0||enemies.size()==0){
      enemies.add(new Enemy(locX,locY));
    }
    //draw enemies and remove ones that touch the player. Also remove lives
    for(int i = 0;i<enemies.size();i++){
      fill(random(0,255),0,0);
      ellipse(enemies.get(i).locX,enemies.get(i).locY,20,20);
      if(dist(enemies.get(i).locX,enemies.get(i).locY,locX,locY)<20){
        enemies.remove(i);
        lives--;
      }
      else{
        //move enemies
        enemies.get(i).movement(locX, locY);
      }
    }
    //calculate and draw score and draw lives
    textAlign(CORNER);
    fill(0);
    if(time%60==0){
      score++;
    }
    text("Score = "+ score + " Lives = " +lives,5,20);
    
    time++;
    //reset all variables minus the last score and high score at the end of the game
    if(lives<=0){
      started = false;
      enemies.clear();
      prevScore = score;
      if(highScore<score){
        highScore = score;
      }
      score = 0;
      locX = width/2;
      locY = height/2;
      
    }
    
  }
  else{
    //draw title screen
    background(0);
    fill(200,200,255);
    textSize(50);
    
    
    textAlign(CENTER);
    text("Project 1 Game",250,250);
    textSize(20);
    fill(180,180,255);
    text("Avoid the enemies",250,290);
    fill(255);
    text("Press Space To Start",250,320);
    textSize(16);
    text("Avoid The Enemies  -  Arrow Keys Control Character",250,350);
    textAlign(LEFT);
    fill(255,0,0);
    stroke(255);
    ellipse(75,375,20,20);
    fill(50,50,255);
    stroke(255);
    ellipse(75,405,20,20);
    fill(255);
    text(" = Enemy",90,380);
    text(" = Player",90,410);
    text("Previous Score = "+prevScore,5,20);
    text("High Score = "+highScore,5,40);
  } 
}

void keyPressed(){
  //start game with space key
  if(!started&& key == ' '){
    started = true;
    score = 0;
    time = 0;
    lives = 3;
  }
  //boolean array for true key presses (allows for multiple key presses)
  if(keyCode == UP){
    keys[0]=true;
  }
  if(keyCode == DOWN){
    keys[1]=true;
  }
  if(keyCode == LEFT){
    keys[2]=true;
  }
  if(keyCode == RIGHT){
    keys[3]=true;
  }
}

void keyReleased(){
  //falsifies boolean array of keys elements when keys are released
  if(keyCode == UP){
    keys[0]=false;
  }
  if(keyCode == DOWN){
    keys[1]=false;
  }
  if(keyCode == LEFT){
    keys[2]=false;
  }
  if(keyCode == RIGHT){
    keys[3]=false;
  }
}

//seperate class for enemy logic
class Enemy{
  int locX;
  int locY;
  int speed;
  Enemy(int x, int y){
    speed = 5;
    //set random location outside of 100pixels from the player
    locX = int(random(10,width-10));
    locY = int(random(10,width-10));
    while(dist(locX,locY,x,y)<=100){
      locX = int(random(10,width-10));
      locY = int(random(10,width-10));
    }
  }
  //calculate movement towards the player
  void movement(int x, int y){
    if(locX<=x){
      locX+=int(random(-speed,speed+1));
    }
    else{
      locX-=int(random(-speed,speed+1));
    }
    if(locY<=y){
      locY+=int(random(-speed,speed+1));
    }
    else{
      locY-=int(random(-speed,speed+1));
    }
    //calculate boundaries for enemies
    if(locX<10){
      locX=10;
    }
    if(locX>490){
      locX=490;
    }
    if(locY<10){
      locY=10;
    }
    if(locY>490){
      locY=490;
    }
    
  }
  
}

