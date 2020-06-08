
//displays background
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
