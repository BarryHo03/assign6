class HPDisplay {
  PImage hpUI;

  HPDisplay(){
    hpUI = loadImage("img/hp.png");
  }
  
  
  void draw(){
    image(hpUI,10,10);
  
  }
  
  void updateWithFighterHP(int hp){
    fill (255,0,0);
    rect(15,10, hp * 2 , 20 ) ;
    image(hpUI,10,10);
  }
  
}
