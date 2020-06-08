
//Code written by Jonah Robinson in 2020
import processing.sound.*;

int invincibilityCounter;
int destroyCounter;

//speed that obstacles move horizontall across the screen
int horizontalSpeed;
int tempSpeed;

// player score in a particular run
int score = 0;

//highest score recorded since the program was opened
int highScore = 0;

//arrays that control the moving background and platforms which I call land
Land[] land;
BackDrop[] backDrop;

PFont fire;
PFont roboto;

//creation of the player object
Player player;

//boolean of whether or not the game has started
boolean started;
//boolean of whether or not infiniteInvincibility is turned on 
boolean infiniteInvincibility;

//array of colors, used in the getRandomColor() function
color[] colors = {color(41, 4, 1), color(227, 41, 215), color(0,0,0), color(237, 237, 47), color(0, 140, 37),
color(179, 9, 32),color(204, 78, 10),color(1, 18, 112),color(66, 13, 94)};

//ArrayLists that facilitate the creation and destruction of obstacles and power ups
ArrayList<Blade> blade;
ArrayList<Cruncher> cruncher;
ArrayList<ChoppingBlock> choppingBlock;
ArrayList<Enemy> enemy;
ArrayList<Bullet> bullet;
ArrayList<Fan> fan;
ArrayList<Invincible> invincible;
ArrayList<Destroyer> destroyer;
ArrayList<Coin> coin;
ArrayList<destructible> destructibles;

//an image array that allows for a lava animation
PImage[] lavaPics;

//main sound loop
SoundFile loop;
//plays when the player dies
SoundFile gameOver;
//plays when the player jumps on and destroys an enemy
SoundFile bonk;
//plays when the player uses the destroyer power up to disintegrate all 
SoundFile destroySound;
//play when powerups are obtained
SoundFile powerUpOne;
SoundFile powerUpTwo;
SoundFile coinHit;

//baseHit and boom play together if the player has invincibility and destroys an obstacle
SoundFile baseHit;
SoundFile boom;


void setup(){
  size(800,600);
  imageMode(CORNER);
  rectMode(CORNER);
  ellipseMode(CORNER);
  noStroke();
  frameRate(60);
  invincibilityCounter = 0;
  destroyCounter = 0;
  started = false;
  infiniteInvincibility = false;
  horizontalSpeed = 5;
  fire = createFont("johnnytorch.ttf",100);
  roboto = createFont("Roboto-Black.tff",100);
  //methods that initialize and load
  loadLists();
  loadLava();
  loadBackground();
  loadSound();
  loadLand();
  //initialization of the player
  player = new Player();
}

void draw(){
  //pressing c causes infiniteInvinsibility until the game is reset
  if(keyPressed && key == 'c'){
    if(infiniteInvincibility == false && invincibilityCounter == 0){
      invincibilityCounter = 600;
      tempSpeed = horizontalSpeed;
      horizontalSpeed *= 3;
      infiniteInvincibility = true;
    }else if(infiniteInvincibility == false && invincibilityCounter > 0){
      invincibilityCounter = 495;
    }
  }
    if(keyPressed && key == 'f' && started == true && player.dead == false && invincibilityCounter> 0){
      if(infiniteInvincibility == true){
        horizontalSpeed = tempSpeed;
      }
      invincibilityCounter = 0;
      infiniteInvincibility = false;
      player.opacity = 255;
      player.xSize = 40;
      player.ySize = 40;
    }
  
  //started == true, run and update the game
  if(started == true){
    if(loop.isPlaying() == false && player.dead == false){
     loop.play();
    }
   if(player.dead == true){
     loop.stop();
   }
  //displays obstacles and powerups and background
  display();
  player.display();
  //if the player is alive, update obstacles and powerups and background
  if(player.dead == false){
    update();
  }
  player.update();
  textAlign(CENTER,CENTER);
  textFont(fire);
  fill(255);
  textSize(30);
  text("high score: " + highScore,150,75);
  text("score: " + score,150,25);
  
  //decrements the destroyCounter if it isn't already zero
  if(destroyCounter > 0){
      destroyCounter--;
  }
  //decrements the invincibilityCounter if it isn't already zero and infiniteInvincibility == false
  if(invincibilityCounter > 0){
    if(infiniteInvincibility == false){
      invincibilityCounter--;
    }else if(infiniteInvincibility == true && invincibilityCounter >= 490){
      invincibilityCounter--;
    }
  }
  //checkForDestroy() checks if the player pressed d and destroys all obstacles if applicable
  checkForDestroy();
  //if started == false, run the title screen
  }else{
    background(200,0,0);
     
    fill(245, 227, 66);
    textSize(100);
    textAlign(CENTER,CENTER);
    textAlign(CENTER);
    textFont(fire);
    text("Krazy Runner",width/2,100);
    textAlign(LEFT);
    fill(255);
    
    textFont(roboto);
    textSize(20);
    text("Press s to start",20,150);
    text("Avoid touching obstacles and lava, however you can jump on shooting enemies to destroy them",20,200);
    text("Fans will reverse the direction your player goes: Watch Out",20,250);
    text("Press j to go up and k to nosedive",20,300);
 
    text("Get coins to boost your score by 3 points",20,350);
    fill(237, 185, 14);
    ellipse(430,320,50,50);
    fill(255);
    text("Get brown circles, they let you destroy all obstacles by pressing d",20,400);
    fill(120, 58, 0);
    ellipse(670,370,50,50);
    fill(255);
    text("Get red circles, they give you temporary invincibility",20,450);
    fill(247, 26, 10);
    ellipse(540,420,50,50);
    fill(255);
    text("CHEAT CODE: press c to turn on infinite invincibility, press f to turn it off",20,500);
    text("Press the mouse down to restart your game",20,550);
    if(keyPressed && key == 's'){
      started = true;
    }
  }
  //if the player is dead, display this graphic
  if(player.dead == true){
    fill(200,0,0);
    rect(width/2 - 100,height/2 -50, 200,100);
    fill(0);
    textFont(fire);
    textSize(60);
    text("DEAD",width/2,height/2);
  }
}

void mousePressed(){
  //resets the game state if the trackpad/mouse is pressed
  reset();
}
