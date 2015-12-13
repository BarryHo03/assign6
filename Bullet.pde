 class Bullet{
	int x = 0;
	int y = 0; 
  PImage shoot;

  Bullet(int x, int y) {
    this.x = x;
    this.y = y;
    shoot= loadImage("img/shoot.png");
  }
  
  void reload(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void showBullet(){
   image(shoot,x,y);  
  }
  
  void move(){
    this.x-=6;
  }  

  boolean isCollideWithEnemy(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh){
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
}
