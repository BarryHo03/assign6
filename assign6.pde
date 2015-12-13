class GameState
{
	static final int START = 0;
	static final int PLAYING = 1;
	static final int END = 2;
}
class Direction
{
	static final int LEFT = 0;
	static final int RIGHT = 1;
	static final int UP = 2;
	static final int DOWN = 3;
}
class EnemysShowingType
{
	static final int STRAIGHT = 0;
	static final int SLOPE = 1;
	static final int DIAMOND = 2;
	static final int STRONGLINE = 3;
}
class FlightType
{
	static final int FIGHTER = 0;
	static final int ENEMY = 1;
	static final int ENEMYSTRONG = 2;
}

int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
Enemy[] enemys = new Enemy[enemyCount];
Boss [] bosses = new Boss[enemyCount];
Bullet[] bullets=new Bullet[5];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPDisplay hpDisplay;
boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 6000;

void setup () {
	size(640, 480);
	flameMgr = new FlameMgr();
	bg = new Background();
	treasure = new Treasure();
  hpDisplay = new HPDisplay();
	fighter = new Fighter(20);
  for(int i=0;i<5;i++){
    bullets[i]=new Bullet(-1, -1); 
  }
}

void draw(){
  if (state == GameState.START) {
    bg.draw();	
  }
  else if (state == GameState.PLAYING) {
    bg.draw();
    treasure.draw();
    flameMgr.draw();
    fighter.draw();
    //enemys
    if(millis() - time >= wait){
      addEnemy(currentType++);
      currentType = currentType%4;
    }
    
    for (int i = 0; i < enemyCount; ++i) {
      if (enemys[i]!= null) {
        enemys[i].move();
        enemys[i].draw();
        if (enemys[i].isCollideWithFighter(enemys[i].x,enemys[i].y, enemys[i].enemyImg.width,enemys[i].enemyImg.height, fighter.x, fighter.y, fighter.fighterImg.width, fighter.fighterImg.height)) {
          fighter.hpValueChange(-20);
          flameMgr.addFlame(enemys[i].x, enemys[i].y);
          enemys[i]=null;
        }
        else if (enemys[i].isOutOfBorder()){
          enemys[i]=null;
        }
      }
    }
    
    for (int i = 0; i < enemyCount; ++i) {
      if (bosses[i]!= null) {
        bosses[i].move();
        bosses[i].draw();
        if (bosses[i].isCollideWithFighter(bosses[i].x,bosses[i].y, bosses[i].enemy2Img.width,bosses[i].enemy2Img.height, fighter.x, fighter.y, fighter.fighterImg.width, fighter.fighterImg.height)) {
          fighter.hpValueChange(-50);
          flameMgr.addFlame(bosses[i].x, bosses[i].y);
          bosses[i]=null;
        }
        else if (bosses[i].isOutOfBorder()){
          bosses[i]=null;
        }
      }
    }
    // show HP
    hpDisplay.updateWithFighterHP(fighter.hp);
    
    //shoot
    fighter.shoot();
    //bulllet on target
    for(int i=0;i<enemyCount;i++){
      for(int j =0;j<5;j++){
        if (enemys[i]!= null) {
          if(bullets[j].x!=-1||bullets[j].y != -1){
            if (bullets[j].isCollideWithEnemy(bullets[j].x, bullets[j].y, bullets[j].shoot.width, bullets[j].shoot.height,enemys[i].x,enemys[i].y, enemys[i].enemyImg.width,enemys[i].enemyImg.height)){
              flameMgr.addFlame(enemys[i].x, enemys[i].y);
              enemys[i]=null;
              bullets[j].x=bullets[j].y=-1;
            }
          }
        }
        if (bosses[i]!= null) {
          if(bullets[j].x!=-1||bullets[j].y != -1){
            if (bullets[j].isCollideWithEnemy(bullets[j].x, bullets[j].y, bullets[j].shoot.width, bullets[j].shoot.height,bosses[i].x,bosses[i].y, bosses[i].enemy2Img.width,bosses[i].enemy2Img.height)){
              bullets[j].x=bullets[j].y=-1;
              bosses[i].hpValueChange(-20);
              if(bosses[i].hp<=0){
                flameMgr.addFlame(bosses[i].x, bosses[i].y);
                bosses[i]=null;
              }
            }
          }
        }        
      }
    }    
  }else if (state == GameState.END) {
    for (int i = 0; i < enemyCount; ++i) {
      enemys[i] = null;
      bosses[i] = null;
    }
    bg.draw(); 
    currentType=EnemysShowingType.STRAIGHT;
   
  }
}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh){
	// Collision x-axis?
  boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
  // Collision y-axis?
  boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
  return collisionX && collisionY;
}

void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased(){
  switch(keyCode){
    case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') {
    if (state == GameState.PLAYING) {
      for(int i =0; i<5;i++){
        if(bullets[i].x==-1){
          bullets[i].reload(fighter.x, fighter.y+fighter.fighterImg.height/2-bullets[i].shoot.height/2);
          break; 
        }
      }
    }
  }
  if (key == ENTER) {
    switch(state) {
      case GameState.START:
      case GameState.END:
        state = GameState.PLAYING;
        enemys = new Enemy[enemyCount];
        flameMgr = new FlameMgr();
        treasure = new Treasure();
        fighter = new Fighter(20);
        for(int i=0;i<5;i++){
          bullets[i]=new Bullet(-1, -1); 
        }
      default : break ;
    }
  }
}
