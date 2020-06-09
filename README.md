# Krazy_Run
Krazy Run is a procedurally generated platformer video game. I created it as a final project in AP Computer Science A. In Krazy Run you control a character that can move up and down but not left to right. Obstacles will begin moving at the player and it must dodge these obstacles. The player will automatically be pulled down and can press "j" to go up and "k" to nosedive. Every 400 pixels a new randomly generated obstacle will come. Your goal is to get as many points as possible through destroying shooting enemies, dodging obstacles and grabbing coins. As your score increases, so does the speed of the game. If you touch an obstacle the player will die. You can restart the program by pressing down on the mouse button. 
### There are 6 distinct kinds of obstacles:
  1. Chopping Block: A Chopping Block is two rectangles which begin to grow from the top and bottom of the screen, leaving a      narrow hole for the player to go through
  2. Cruncher: A cruncher is a large rectangle which only has a small opening at the top and bottom for the player to go         through.
  (cruncher.gif)
  3. Blade: A blade is a small rectangle which quickly moves up and down.
  4. Enemy: The enemy is a semi-circle. You can destroy the enemy by jumping on it from the top but the player will die if it      hits the enemy from the side. The enemy will shoot bullets targeted at you. 
  5. Fan: the fan can't directly kill the player, but it does reverse the direction that the player is naturally pulled, and amplifies the push from pressing "j" and weakens the push from "k".
  6. Lava: Lava is simple, you can't fall in it or the player dies, however sometimes lava will give you a power up, there are  3 types of powerups
  
  ### power ups
  1. Coin: Getting a coin increases the score by 3
  2. Destroyer(Brown Circle): If you get a destroyer, you get an aprox. 10 second window to press d and disintegrate all            obstacles in your path.
  3. Invincibility: Gaining Invincibility will enlarge your player, increases its speed, and allow you to destroy all              obstacles you touch. Before you lose invincibility you will go into slow-motion and shrink back to regular size. 
### Dependencies
The entire program is written in Processing 3. f you don’t already have processing you can download it off the internet: https://processing.org/download/. This program only uses one external library: processing.sound.

### Usage:
Clone my code with git. Once you have all the files on your computer, you can play the game by opening a one of .pde and pressing the play button in the processing environment. It should be noted that I wasn't able to export a version of this program that worked. 

### Code Explanation
A class called BackDrop is used for the background
```processing
class BackDrop{
  int x;
  PImage backDropImg;
  BackDrop(PImage backDropImg, int x){
    this.backDropImg = backDropImg;
    this.x = x;
  }
  void display(){
    image(backDropImg,x,0);
    if(player.dead == false){
      x-= 2;
    }
    if(x == -400){
      x = 800;
    }
  }
}
```
A class called Land is used to show the ground, in the update method of the Land class, if the Land goes off screen, it will reset to the right side of the screen and a new random obstacle will be spawned
```processing
if(x <= -400){
      //pick a random number, giving each list of obstacles a one in eight chance of having a new one created
      randOne = Math.random();
      if(randOne < 0.125){
        lava = false;
        blade.add(new Blade(1000 + (x + 400),(int)(399 * Math.random()) + 1,50,100,blade.size()));
      }else if(randOne <0.25){
        lava = false;
        cruncher.add(new Cruncher(950 + (x + 400),100,100,300,cruncher.size()));
      }else if(randOne <0.375){
        lava = false;
        choppingBlock.add(new ChoppingBlock(975 + (x + 400),0,0,0,1,3,choppingBlock.size()));
      }else if(randOne <0.5){
        lava = false;
        choppingBlock.add(new ChoppingBlock(975 + (x + 400),0,0,0,2,2,choppingBlock.size()));
      }else if(randOne < 0.625){
        lava = false;
        choppingBlock.add(new ChoppingBlock(975 + (x + 400),0,0,0,3,1,choppingBlock.size()));
      }else if(randOne < 0.75){
        lava = false;
        fan.add(new Fan( 1000 + (x + 400), getRandomColor()));
      }else if(randOne < 0.875){
        lava = false;
        enemy.add(new Enemy(980 + (x + 400),460,40,80,enemy.size()));
      }else{
        lava = true;
        lavaIndex = (int)(Math.random() * 46);
        //if lava is selected as the obstacle, use a new random number to determine the powerup above the lava
        randTwo = Math.random();
        if(randTwo <= 0.25){
          if(invincibilityCounter == 0){
            invincible.add(new Invincible(975 + (x + 400),color(247, 26, 10)));
          }else{
            coin.add(new Coin(975 + (x + 400),color(237, 185, 14)));
          }
        }else if(randTwo <= 0.5){
          if(destroyCounter == 0){
            destroyer.add(new Destroyer(975 + (x + 400),color(120, 58, 0)));
          }else{
            coin.add(new Coin(975 + (x + 400),color(237, 185, 14)));
          }
        }else if(randTwo <0.75){
          coin.add(new Coin(975 + (x + 400),color(237, 185, 14)));
      }
      }
      score++;
      if(score > highScore){
        highScore = score;
      }
      //increases in speed are tied to how high the score is
      if(invincibilityCounter == 0){
        horizontalSpeed = 5 + score/10;
      }else{
        tempSpeed = 5 + score/10;
      }
      //set the x position back to the right edge as if the land's movement is in a cycle
      x = 800 + (x + 400);
     }  
   }
```
The Obstacle class acts as the parent class for most other obstacle classes such as ChoppingBlock, Blade, Cruncher, and Enemy
```processing
class Obstacle{
  int x;
  int y;
  int xSize,ySize;
  color Color;
  int index;
  Obstacle(int x,int y, int xSize, int ySize, int index){
    this.x = x;
    this.Color = getRandomColor();
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
    this.index = index;
  }
  void display(){
    rectMode(CORNER);
    fill(Color);
    rect(x,y,xSize,ySize);
  }
  void update(){
    x -= horizontalSpeed;
    if(playerCollision(x,y,xSize,ySize) && invincibilityCounter == 0){
      player.kill();
    }
  }
}

```
The Enemy class deviate significantly from the parent Obstacle class, the Enemy class has additional conditionals that allow for the player to destroy the enemy if it hits the enemy from the top. The enemy also launches bullets periodically. Here's the overidden update method.
```processing
 void update(){
    //if the player is too close to the enemy, it isn't allowed to shoot
    if(playerCollision(x - 50,y - 100,140,150)){
      shotAllowed = false;
    }else{
      shotAllowed = true;
    }
    if(x < -xSize){
      enemy.remove(0);
      for(int i = 0; i<enemy.size(); i++){
         enemy.get(i).index--;
      }
    }
    if(dead == false){
    x -= horizontalSpeed;
    //if the player hits the enemy from the top, the enemy dies
    if((player.x >= x - player.xSize && player.x <= x + 40 )
    && (player.y >= 460 - player.ySize && player.y < 460 - player.ySize + 15)){
      score++;
      if(invincibilityCounter == 0){
        this.dead = true;
        bonk.play();
      }else{
        if(baseHit.isPlaying()){
          baseHit.stop();
        }
          baseHit.play();
           boom.play();
        destructibles.add(new destructible(enemy.get(index).x,460,4,4,color(196, 56, 10),destructibles.size()));
        
        enemy.remove(index);
        
       for(int i = index; i<enemy.size(); i++){
         enemy.get(i).index--;
      }
      }
     // if the player hits the enemy from the side, the player dies
    }else if(playerCollision(x,y,xSize,ySize)){
      if(invincibilityCounter == 0){
      player.kill();
      }else{
        if(baseHit.isPlaying()){
          baseHit.stop();
        }
          baseHit.play();
          boom.play();
        destructibles.add(new destructible(enemy.get(index).x,460,4,4,color(196, 56, 10),destructibles.size()));
        enemy.remove(index);
       for(int i = index; i<enemy.size(); i++){
         enemy.get(i).index--;
       }
      }
    }
    
    shotTimer++;
    if(shotTimer >= 90 && shotAllowed){
      shotTimer = 0;
      xDistance = (x - 20) - player.x;
      yDistance = 460 - player.y +50;
      //the distance between the player and enemy is gauged and used to launch a bullet at the player
      bullet.add(new Bullet(x - 20,y,10,10,(int)(xDistance / 60), (int) (yDistance / 60), bullet.size()));
    }
    }
    
  }
```
The Fan class is written seperately from the Obstacle class. The Fan makes use of pushMatrix() and popMatrix() and transformations such as translations and rotations. This allows for the Fan to smoothly rotate. 
```processing
class Fan{
  int x;
  int degrees;
  color Color;
  Fan(int x, color Color){
    this.x = x;
    degrees = 0;
    this.Color = Color;
  }
  void display(){
    //the fan is displayed as 3 rotating rectangles
    noStroke();
    fill(Color);
    rectMode(CENTER);
    pushMatrix();
    translate(x,550);
    pushMatrix();
    rotate(radians(degrees));
    rect(0, 0, 100, 16);
    popMatrix();
    pushMatrix();
    rotate(radians(degrees + 120));
    rect(0, 0, 100, 16);
    popMatrix();
    pushMatrix();
    rotate(radians(degrees + 240));
    rect(0, 0, 100, 16);
    popMatrix();
    popMatrix();
  }
  void update(){
    degrees+= 8;
    x-= horizontalSpeed;
    if(degrees == 360){
    degrees = 0;
    }
    if(x <= -50){
      fan.remove(0);
    }
  }
  //returns true if the player is above a particular fan
  boolean alignsWithPlayer(){
    if(player.x >= x - 200 && (player.x <= x + 160)){
    return true;
    }else{
    return false;
    }
  }
}
```
In order for the Fan to be able to reverse the direction of the player, a complicated variety of code is required in the the Player class. Three variables called push, antiPush, and gravity are used to control the vertical movement of the player.
```processing
if(keyPressed && key == 'j'){
      if(this.y > 0){
        y += push;
      }
    }else if(keyPressed && key == 'k'){
      if(this.y < 500 - ySize){
        y += antiPush;
      }
    }else{ 
      if(this.y < 500 - ySize && gravity == 5){
        y += gravity;
      }else if(this.y > 0 && gravity == -5){
        y += gravity;
      }
    }
```
The boolean function playerAboveFan returns true if the player above the fan. 
```processing
boolean playerAboveFan(){
    for(int i = 0; i<fan.size(); i++){
      if(fan.get(i).alignsWithPlayer() == true){
        return true;
      }
    }
    return false;
  }
```
If the player changes from being above a fan to not being above a fan or vice-versa, the air current reverses
```processing
if(this.playerAboveFan()){
      if(currentReversed == false){
        this.reverseAirCurrent();
      }
    }else{
      if(currentReversed == true){
        this.reverseAirCurrent();
      }
    }
```
The reverseAirCurrent method is what causes the reversal of direction
```processing
void reverseAirCurrent(){
    if(gravity == 5){
       currentReversed = true;
       gravity = -5;
       antiPush = 5;
       push = -10;
    }else{
      currentReversed = false;
      gravity = 5;
      antiPush= 10;
      push = -5;
    }
  }
```
The destructible class allows for a very cool disintegration effect of obstacles. A destructible object displays an array of circles which group together to form an apprent rectangle. The circles then move quickly in random directions as their size decreases, making it seem as if the rectangle is disintegrating. The destructible class initializes an array of ovals objects named firstWave based on a specified number of columns and rows. 
```processing
destructible(int x, int y, int rows, int collumns, color gameColor, int number){
    index= 0;
    xSize = 10;
    ySize = 10;
    this.x = x;
    this.y = y;
    this.gameColor = gameColor;
    this.rows =  rows;
    this.columns = collumns;
    this.number = number;
    //loop that initializes and positions every oval in the firstWave array, giving each a randomX and ySpeed
    firstWave= new oval[rows * columns];
     while(index < firstWave.length){
      for(int z = 0; z < columns; z++){
        for(int k = 0; k <rows; k++){
          int randX = (int)(Math.random() * 10) + 1;
          int randY = (int)(Math.random() * 10) + 1;
          if(Math.random() > 0.5){
            randY = -randY;
          }
          if(Math.random() > 0.5){
            randX = -randX;
          }
          firstWave[index] = new oval(x + z * 10 ,y + k * 10, xSize,ySize, randX, randY,gameColor);
          index++;
        }
      }
  }
  }
```
The oval class is an ellipse of changing position and size. 
```processing
class oval{
  int x,y;
  int xSize,ySize;
  int xSpeed, ySpeed;
  color gameColor;
  oval(int x, int y, int xSize, int ySize, int xSpeed, int ySpeed, color gameColor){
    this.x = x;
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.gameColor = gameColor;
  }
  void display(int xSize, int ySize){
    this.xSize = xSize;
    this.ySize = ySize;
    fill(gameColor);
    ellipseMode(CORNER);
    ellipse(x,y,xSize,ySize);
    x -= horizontalSpeed;
  }
  void update(){
    x += xSpeed;
    y += ySpeed;
  }
  
}
```


Obstacles and PowerUps are displayed and updated through a method called Display and a Method called Update. These methods are run in Draw().  Every type of PowerUp and obstacle has its own ArrayList that adds and removes objects to create and destroy obstacles and PowerUps. 
```processsing
void display(){
  
  for(int i = 0; i< backDrop.length; i++){
    backDrop[i].display();
  }
  
  for(int i = 0; i< enemy.size(); i++){
    enemy.get(i).display();
  }
  for(int i = 0; i< coin.size(); i++){
    coin.get(i).display();
  }
  for(int i = 0; i< destroyer.size(); i++){
    destroyer.get(i).display();
  }
  
  for(int i = 0; i< invincible.size(); i++){
    invincible.get(i).display();
  }
  
  for(int i = 0; i< land.length; i++){
    land[i].display();
  }
  
  for(int i = 0; i< blade.size(); i++){
    blade.get(i).display();
  }
  
  for(int i = 0; i< cruncher.size(); i++){
    cruncher.get(i).display();
  }
  
  for(int i = 0; i< choppingBlock.size(); i++){
    choppingBlock.get(i).display();
  }
  for(int i = 0; i< fan.size(); i++){
    fan.get(i).display();
  }
  for(int i = 0; i< bullet.size(); i++){
    bullet.get(i).display();
  }
  for(int i = 0; i < destructibles.size(); i++){
      destructibles.get(i).display();
    }
}
//updates powerups and obstacles
void update(){
  for(int i = 0; i< invincible.size(); i++){
    invincible.get(i).update();
  }
  for(int i = 0; i< coin.size(); i++){
    coin.get(i).update();
  }
  for(int i = 0; i< destroyer.size(); i++){
    destroyer.get(i).update();
  }
    for(int i = 0; i< enemy.size(); i++){
    enemy.get(i).update();
  }
  
  for(int i = 0; i< land.length; i++){
    land[i].update();
  }
  
  for(int i = 0; i< blade.size(); i++){
    blade.get(i).update();
  }
  
  for(int i = 0; i< cruncher.size(); i++){
    cruncher.get(i).update();
  }
  
  for(int i = 0; i< choppingBlock.size(); i++){
    choppingBlock.get(i).update();
  }
  for(int i = 0; i< fan.size(); i++){
    fan.get(i).update();
  }
  for(int i = 0; i< bullet.size(); i++){
    bullet.get(i).update();
  }
}
```
Additionally, there are several other crucial helper methods in this program such as getRandomColor which returns a random color from an array, playerCollision, which returns true if the player is in a collision with a rectangle with a specified x and y pos and size. And reset which resets the game by changing values back to what they were initially and clearing ArrayLists of Obstacles and PowerUps.
```processing
//returns a random color from the colors array
color getRandomColor(){
  int rnd = (int)(Math.random() * colors.length);
  return colors[rnd];
}

//returns true if the player is in a collision with a rectangle with a specified x and y pos and size
boolean playerCollision(int x, int y, int xSize, int ySize){
  if(player.x >= x - player.ySize 
     && player.x <= x + xSize
     && (player.y >= y - player.ySize)
     && (player.y <= y + ySize)){
       return true;
   }else{
     return false;
   }
}

void reset(){
  //resets the game by changing values back to what they were initially and clearing lists
  land[0].x = 0;
  land[1].x = 400;
  land[2].x = 800;
  for(int i = 0; i<land.length; i++){
    land[i].lava = false;
  }
  blade.clear();
  cruncher.clear();
  choppingBlock.clear();
  enemy.clear();
  bullet.clear();
  fan.clear();
  invincible.clear();
  destroyer.clear();
  coin.clear();
  player.x = width/2 - 20;
  player.y = 230;
  player.xSize = 40;
  player.ySize = 40;
  player.gravity = 5;
  player.push = -5;
  player.antiPush = 10;
  player.currentReversed = false;
  player.dead = false;
  player.opacity = 255;
  destroyCounter = 0;
  invincibilityCounter = 0;
  horizontalSpeed = 5;
  score = 0;
  infiniteInvincibility = false;
  
}
```
### Credits:
All Sound was either made in-house or found on freesound.org
1. https://freesound.org/people/jnr%20hacksaw/sounds/11221/
2. https://freesound.org/people/uzerx/sounds/59537/
3. https://freesound.org/people/ProjectsU012/sounds/341695/
4. https://freesound.org/people/TheDweebMan/sounds/277214/
5. https://freesound.org/people/GameAudio/sounds/220173/
6. https://freesound.org/people/Robinhood76/sounds/273332/
Credit for Lava Images:
https://opengameart.org/content/16x16-and-animated-lava-tile-45-frames


### Insight / Motivation:
This game allowed for me to create a platformer with unique visual effects, obstacles, and powerups. It presented numerous technical challenges that I was able to resolve through trying new approaches. I controlled obstacles creation and destrucion by holding them in ArrayLists. I wanted to add a cheat code so I added a conditional to allow it. I wanted a cool disintegration effect so I made my own class of which displayed a randomly moving array of circles. The end result is a fun game that I'm proud to call my own. 


