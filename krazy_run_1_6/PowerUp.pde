
//PowerUp is the base class for Invincible, Coin, and Destroyer
class PowerUp{
  int x;
  int y;
  color Color;
  PowerUp(int x,color Color){
    this.x = x;
    this.y = (int)(300* Math.random());
    this.Color = Color;
  }
  void display(){
    fill(Color);
    ellipse(x,y,50,50);
  }
  void update(){
    this.x -= horizontalSpeed;
  }
}

class Invincible extends PowerUp{
  Invincible(int x,color Color){
  super(x,Color);
  }
  void update(){
    this.x -= horizontalSpeed;
    if(playerCollision(x,y,50,50)){
      //if the player collides with an Invincible object, it will be granted invincibility for 600 frames
      invincibilityCounter = 600;
      tempSpeed = horizontalSpeed;
      horizontalSpeed *= 3;
      powerUpTwo.play();
      invincible.clear();
    }
    if(this.x <= -55){
      invincible.remove(0);
    }
  }
}

class Destroyer extends PowerUp{
  Destroyer(int x,color Color){
  super(x,Color);
  }
  void update(){
    this.x -= horizontalSpeed;
    if(playerCollision(x,y,50,50)){
      //if the player collides with an Destroyer object, it will be granted the ability to destroy for 600 frames
      destroyCounter = 600;
      powerUpOne.play();
      destroyer.clear();
    }
    if(this.x <= -55){
      destroyer.remove(0);
    }
  }
}

class Coin extends PowerUp{
  boolean dead;
  Coin(int x,color Color){
  super(x,Color);
  dead = false;
  }
  void display(){
    if(dead == false){
      fill(Color);
      ellipse(x,y,50,50);
    }
  }
  void update(){
    this.x -= horizontalSpeed;
    if(playerCollision(x,y,50,50) && dead == false){
      score += 3;
      dead = true;
      coinHit.play();
    }
    if(this.x <= -55){
      coin.remove(0);
    }
  }
}
