
//a special class that displays rectangles formed by groups of smaller circles(made up of the oval class)
// which then fly randomly and decrease in size
class destructible{
 
  int index;
  int xSize;
  int ySize;
  int randX;
  int randY;
  int x,y;
  //the firstWave oval[] is where the small circles are created and stored
  oval[] firstWave;
  int counter = 0;
  //the length of firstWave and the created "rectangle" depend on the number of rows and columns specified
  int rows, columns;
  color gameColor;
  //number acts as an index for the destructibles list
  int number;
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
  void display(){
      for(int i = 0; i<firstWave.length; i++){
        firstWave[i].display(xSize,ySize);
        if(counter > 5){
        firstWave[i].update();
        }
      }
      if(counter % 5== 0 && xSize > 0){
        //decreases the size of the firstWave ovals over time
        xSize--;
        ySize--;
      }
      //removes destructible objects as appropriate
      if(xSize == 0){
        destructibles.remove(number);
       for(int i = number; i<destructibles.size(); i++){
         destructibles.get(i).number--;
      }
      }
      counter++;
    }
}
  
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
