



//displays powerups and obstacles and the background
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
