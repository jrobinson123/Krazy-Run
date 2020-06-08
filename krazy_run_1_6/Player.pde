
class Player{
  int x,y;
  int gravity;
  int push,antiPush;
  int xSize,ySize;
  boolean dead;
  boolean currentReversed;
  int opacity;
  Player(){
    x = width/2 - 20;
    y = 230;
    xSize = 40;
    ySize = 40;
    //gravity pushes the player up or down depending on whether air current is reversed. 
    gravity = 5;
    //push pushes the player up, but with more or less magnitude depending on air current
    push = -5;
    //antiPush pushes the player down, but with more or less magnitude depending on air current
    antiPush = 10;
    opacity = 255;
    //the air current initially starts un-reversed
    currentReversed = false;
    dead = false;
  }
  void display(){
    rectMode(CORNER);
    if(destroyCounter == 0){
      fill(255,opacity);
    }else{
      fill(120, 58, 0,opacity);
    }
    rect(x,y,xSize,ySize,(int)xSize/4);
    
  }
  void update(){
    if(dead == false){
    if(invincibilityCounter > 0){
      if(invincibilityCounter > 1){
      //flashes the players opacity when it is invincible
      opacity = (int) (150 * Math.random() + 50);
      }else{
        opacity = 255;
      }
      //expands an contracts the size of the player when it is invincible
      if(invincibilityCounter <= 585 && invincibilityCounter >= 501){
        xSize++;
        ySize++;
      }else if(invincibilityCounter <=135 && invincibilityCounter >=51){
        xSize--;
        ySize--;
      }
      if(invincibilityCounter < 190 && invincibilityCounter > 51){
        horizontalSpeed = 3;
      }
      if(invincibilityCounter == 51){
        horizontalSpeed = tempSpeed;
      }
    }
    //if the player changes from being above a fan to not being above a fan or vice-versa, the air current reverses
    if(this.playerAboveFan()){
      if(currentReversed == false){
        this.reverseAirCurrent();
      }
    }else{
      if(currentReversed == true){
        this.reverseAirCurrent();
      }
    }
    //controls how keys move the player
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
    }else{
      //shrivels up the player if it's dead
      if(xSize > 0){
      xSize-=2;
      ySize-=2;
      }
    }
  }
  //will reverse th air current applied on the player
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
  //returns true if the player is above any Fan object
  boolean playerAboveFan(){
    for(int i = 0; i<fan.size(); i++){
      if(fan.get(i).alignsWithPlayer() == true){
        return true;
      }
    }
    return false;
  }
  void kill(){
    if(gameOver.isPlaying() == false){
      gameOver.play();
    }
    dead = true;
  }
}
