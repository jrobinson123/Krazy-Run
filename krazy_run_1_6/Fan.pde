
//the Fan is a special obstacle that blows the player up 
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
