

//Obstacle is the parent class of obstacles such as ChoppingBlock, Blade, Cruncher, Enemy, and Bullet

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

//the blade is an obstacle that bounces up and down
class Blade extends Obstacle{
  int verticalSpeed;
  Blade(int x,int y, int xSize, int ySize, int index){
    super(x, y,xSize, ySize,index);
    verticalSpeed = 6;
  }
  void update(){
    x -= horizontalSpeed;
    //kills the player or obstacle depending on invincibilityCounter
    if(playerCollision(x,y,xSize,ySize)){
      if(invincibilityCounter == 0){
      player.kill();
      }else{
        destructibles.add(new destructible(blade.get(index).x,blade.get(index).y,10,5,blade.get(index).Color, destructibles.size()));
        blade.remove(index);
        if(baseHit.isPlaying()){
          baseHit.stop();
        }
          baseHit.play();
          boom.play();
       for(int i = index; i<blade.size(); i++){
         blade.get(i).index--;
       }
      }
    }
    //the blade obstacle moves up and down vertically
    y += verticalSpeed;
    if(y > 400 || y <= 0){
      verticalSpeed = -verticalSpeed;
    }
    if(x < -xSize){
      blade.remove(0);
      for(int i = 0; i<blade.size(); i++){
         blade.get(i).index--;
      }
    }
  }
}

//Cruncher is a long rectangle that forces the player to go to the bottom
class Cruncher extends Obstacle{
  Cruncher(int x,int y, int xSize, int ySize,int index){
    super(x,y,xSize,ySize,index);
  }
  void update(){
    x -= horizontalSpeed;
    //if a collision with the player occurs, kills the player or obstacle depending on invincibilityCounter
    if(playerCollision(x,y,xSize,ySize)){
      if(invincibilityCounter == 0){
      player.kill();
      }else{
        destructibles.add(new destructible(cruncher.get(index).x,100,30,10,cruncher.get(index).Color,destructibles.size()));
        cruncher.remove(index);
        if(baseHit.isPlaying()){
          baseHit.stop();
        }
          baseHit.play();
          boom.play();
       for(int i = index; i<cruncher.size(); i++){
         cruncher.get(i).index--;
       }
      }
    }
    if(x < -xSize){
      cruncher.remove(0);
      for(int i = 0; i<cruncher.size(); i++){
         cruncher.get(i).index--;
      }
    }
  }
}
//ChoppingBlock is two rectangles that grow from the top and bottom of the screen
class ChoppingBlock extends Obstacle{
  int topSpeed;
  int bottomSpeed;
  int topY;
  int bottomY;
  ChoppingBlock(int x,int y, int xSize, int ySize, int topSpeed, int bottomSpeed, int index){
    //xSize and ySize and y are not used for choppingBlock
    super(x,y,xSize,ySize, index);
    this.topSpeed = topSpeed;
    this.bottomSpeed = bottomSpeed;
    this.topY = 0;
    this.bottomY = 0;
  }
  
  void display(){
    rectMode(CORNER);
    fill(Color);
    rect(x,0,50,topY);
    rect(x,500 - bottomY,50,bottomY);
  }
  void update(){
    //if a collision with the player occurs, kills the player or obstacle depending on invincibilityCounter
    if(playerCollision(x,500 - bottomY,50,bottomY) || playerCollision(x,0,50,topY)){
      if(invincibilityCounter == 0){
      player.kill();
      }else{
        if(baseHit.isPlaying()){
          baseHit.stop();
        }
          baseHit.play();
          boom.play();
        destructibles.add(new destructible(choppingBlock.get(index).x,0,choppingBlock.get(index).topY/10,5, choppingBlock.get(index).Color,destructibles.size()));
        destructibles.add(new destructible(choppingBlock.get(index).x,500 - choppingBlock.get(index).bottomY, choppingBlock.get(index).bottomY/10,5, choppingBlock.get(index).Color,destructibles.size()));
        choppingBlock.remove(index);
       for(int i = index; i<choppingBlock.size(); i++){
         choppingBlock.get(i).index--;
       }
      }
    }
    x -= horizontalSpeed;
    if(x < -50){
      choppingBlock.remove(0);
      for(int i = 0; i<choppingBlock.size(); i++){
         choppingBlock.get(i).index--;
      }
    }
    //after a certain x-point, the rectangles will begin to grow in size
     if(bottomY + topY <=500 && x <= 700){
      bottomY += bottomSpeed;
      topY += topSpeed;
    }
  }
}

//Enemy's shoot deadly bullets at the player
class Enemy extends Obstacle{
  int shotTimer;
  int xDistance;
  int yDistance;
  boolean dead;
  //determines whether or not a shot is allowed
  boolean shotAllowed;
  Enemy(int x,int y, int xSize, int ySize, int index){
    super(x,y,xSize,ySize, index);
    Color = color(196, 56, 10);
    shotTimer = 0;
    dead = false;
    shotAllowed = true;
  }
  void display(){
    if(dead == false){
    fill(Color);
    ellipse(x,y,xSize,ySize);
    }
  }
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
        enemy.remove(index);
       for(int i = index; i<enemy.size(); i++){
         enemy.get(i).index--;
       }
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
}

class Bullet extends Obstacle{
    int bulletSpeedX, bulletSpeedY;
    Bullet(int x,int y, int xSize, int ySize, int bulletSpeedX, int bulletSpeedY,int index){
    super(x,y,xSize,ySize, index);
    this.bulletSpeedX = bulletSpeedX;
    this.bulletSpeedY = bulletSpeedY;
    Color = color(207, 115, 35); 
  }
  void update(){
    //if a collision with the player occurs, kills the player or obstacle depending on invincibilityCounter
    if(playerCollision(x,y,xSize,ySize)&& invincibilityCounter == 0){
      player.kill();
    }
    //the bullet is a projectile that moves through the air with a certain x and y velocity
    x -= bulletSpeedX;
    y -= bulletSpeedY;
    if(x < -10 || x > width || y < -10 || y > height || (playerCollision(x,y,xSize,ySize) && invincibilityCounter > 0)){
       bullet.remove(index);
       for(int i = index; i<bullet.size(); i++){
         bullet.get(i).index--;
       }
    }
  }
}
