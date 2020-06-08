

//Land class represents the ground that the player steps on, it also controls the creation of new obstacles and powerups
class Land{
  int x;
  PImage img;
  double randOne;
  double randTwo;
  boolean lava;
  int lavaIndex;
  Land(int x, PImage img){
    this.x = x;
    this.img = img;
    lava = false;
  }
  void display(){
    //if lava is false display the normal image, else display the lava image
    if(lava == false){
      image(img,x,500);
    }else{
      image(lavaPics[lavaIndex],x,500);
      if(player.dead == false){
        lavaIndex++;
      }
      if(lavaIndex > 45){
        lavaIndex = 0;
      }
    }
  }
  void update(){
    //if lava is true and the player collides with the ground, kill the player
    if(lava == true){
       if(invincibilityCounter == 0
         && player.x >= x - 40 
         && player.x <= x + 400
         && (player.y >=460)){
           player.kill();
         }
     }
    x -= horizontalSpeed;
    //if the land is offscreen
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
}
