class Boss  {
  PImage enemy2Img;
  int hp;
  int x;
  int y;
  int type;
  Boss(int x, int y, int type){
    enemy2Img = loadImage("img/enemy2.png");
    this.x = x;
    this.y = y;
    this.type = type;
    this.hp=100;
  }
  
  void draw(){
    image(enemy2Img, x, y);
  }
  
  void move(){
    x+=2;
  }
  
  boolean isCollideWithFighter(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh){
      // Collision x-axis?
    boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
    // Collision y-axis?
    boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
    if(collisionX && collisionY){
      return true;
    }else{
      return false;
    }
  }
  
  boolean isOutOfBorder(){
    if(this.x>width){
      return true;
    }else{
      return false;
    }
  }
  
  
  void hpValueChange(int value){
    this.hp+=value;
  } 
}
