

//initializes the ArrayLists used
void loadLists(){
  blade = new ArrayList<Blade>();
  cruncher = new ArrayList<Cruncher>();
  choppingBlock = new ArrayList<ChoppingBlock>();
  enemy = new ArrayList<Enemy>();
  bullet = new ArrayList<Bullet>();
  fan = new ArrayList<Fan>();
  invincible = new ArrayList<Invincible>();
  destroyer = new ArrayList<Destroyer>();
  coin = new ArrayList<Coin>();
  destructibles = new ArrayList<destructible>();
}
//initializes objects from the land array
void loadLand(){
  land = new Land[3];
  land[0] = new Land(0,loadImage("platform1.png"));
  land[1] = new Land(400,loadImage("platform2.png"));
  land[2] = new Land(800,loadImage("platform3.png"));
}
//initializes objects from the backDrop array
void loadBackground(){
  backDrop = new BackDrop[3];
  backDrop[0] = new BackDrop(loadImage("leftBackground.png"),0);
  backDrop[1] = new BackDrop(loadImage("midBackground.png"),400);
  backDrop[2] = new BackDrop(loadImage("rightBackground.png"),800);
}

//initializes SoundFiles
void loadSound(){
  loop = new SoundFile(this, "platformLoop.wav");
  loop.amp(0.3);
  gameOver = new SoundFile(this, "gameOver.wav");
  gameOver.amp(0.3);
  bonk = new SoundFile(this, "bonk.wav");
  bonk.amp(0.3);
  destroySound = new SoundFile(this,"destroySound.wav");
  destroySound.amp(0.3);
  powerUpOne = new SoundFile(this,"powerUp.wav");
  powerUpOne.amp(0.3);
  powerUpTwo = new SoundFile(this,"powerUpTwo.wav");
  powerUpTwo.amp(0.3);
  coinHit = new SoundFile(this,"coinHit.wav");
  coinHit.amp(0.3);
  baseHit = new SoundFile(this,"baseHit.wav");
  baseHit.amp(1.0);
  boom = new SoundFile(this,"destruction.mp3");
  boom.amp(0.3);
}
//sets images in the lavaPics array
void loadLava(){
  lavaPics = new PImage[46];
  lavaPics[0] = loadImage("10000.png");
  lavaPics[1] = loadImage("10001.png");
  lavaPics[2] = loadImage("10002.png");
  lavaPics[3] = loadImage("10003.png");
  lavaPics[4] = loadImage("10004.png");
  lavaPics[5] = loadImage("10005.png");
  lavaPics[6] = loadImage("10006.png");
  lavaPics[7] = loadImage("10007.png");
  lavaPics[8] = loadImage("10008.png");
  lavaPics[9] = loadImage("10009.png");
  lavaPics[10] = loadImage("10010.png");
  lavaPics[11] = loadImage("10011.png");
  lavaPics[12] = loadImage("10012.png");
  lavaPics[13] = loadImage("10013.png");
  lavaPics[14] = loadImage("10014.png");
  lavaPics[15] = loadImage("10015.png");
  lavaPics[16] = loadImage("10016.png");
  lavaPics[17] = loadImage("10017.png");
  lavaPics[18] = loadImage("10018.png");
  lavaPics[19] = loadImage("10019.png");
  lavaPics[20] = loadImage("10020.png");
  lavaPics[21] = loadImage("10021.png");
  lavaPics[22] = loadImage("10022.png");
  lavaPics[23] = loadImage("10023.png");
  lavaPics[24] = loadImage("10024.png");
  lavaPics[25] = loadImage("10025.png");
  lavaPics[26] = loadImage("10026.png");
  lavaPics[27] = loadImage("10027.png");
  lavaPics[28] = loadImage("10028.png");
  lavaPics[29] = loadImage("10029.png");
  lavaPics[30] = loadImage("10030.png");
  lavaPics[31] = loadImage("10031.png");
  lavaPics[32] = loadImage("10032.png");
  lavaPics[33] = loadImage("10033.png");
  lavaPics[34] = loadImage("10034.png");
  lavaPics[35] = loadImage("10035.png");
  lavaPics[36] = loadImage("10036.png");
  lavaPics[37] = loadImage("10037.png");
  lavaPics[38] = loadImage("10038.png");
  lavaPics[39] = loadImage("10039.png");
  lavaPics[40] = loadImage("10040.png");
  lavaPics[41] = loadImage("10041.png");
  lavaPics[42] = loadImage("10042.png");
  lavaPics[43] = loadImage("10043.png");
  lavaPics[44] = loadImage("10044.png");
  lavaPics[45] = loadImage("10045.png");
}
