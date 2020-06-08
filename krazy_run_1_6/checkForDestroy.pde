
//check for destroy will destroy every obstacle if the destroyCounter is greater than zero
void checkForDestroy(){
  if(keyPressed && key == 'd' && destroyCounter > 0 && player.dead == false){
    destroySound.play();
    
   for(int i = 0; i<choppingBlock.size(); i++){
     destructibles.add(new destructible(choppingBlock.get(i).x,0,choppingBlock.get(i).topY/10,5, choppingBlock.get(i).Color,destructibles.size()));
     destructibles.add(new destructible(choppingBlock.get(i).x,500 - choppingBlock.get(i).bottomY, choppingBlock.get(i).bottomY/10,5, choppingBlock.get(i).Color,destructibles.size()));
   }
   choppingBlock.clear();
    for(int i = 0; i<cruncher.size(); i++){
     destructibles.add(new destructible(cruncher.get(i).x,100,30,10,cruncher.get(i).Color,destructibles.size()));
   }
   cruncher.clear();
   
   for(int i = 0; i<bullet.size(); i++){
     destructibles.add(new destructible(bullet.get(i).x,bullet.get(i).y,1,1,color(207, 115, 35),destructibles.size()));
   }
    bullet.clear();
    
    for(int i = 0; i<enemy.size(); i++){
     destructibles.add(new destructible(enemy.get(i).x,460,4,4,color(196, 56, 10),destructibles.size()));
   }
    enemy.clear();
    for(int i = 0; i<fan.size(); i++){
     destructibles.add(new destructible(fan.get(i).x - 50,540,2,10,fan.get(i).Color,destructibles.size()));
     destructibles.add(new destructible(fan.get(i).x - 10,500,10,2,fan.get(i).Color,destructibles.size()));
   }
    fan.clear();
   for(int i = 0; i<blade.size(); i++){
     destructibles.add(new destructible(blade.get(i).x,blade.get(i).y,10,5,blade.get(i).Color,destructibles.size()));
   }
    blade.clear();
    destroyCounter = 0;
  }
}
