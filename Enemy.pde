class Enemy{
	int x = 0;
	int y = 0;
	int type;
	int speed = 5;

  PImage enemyImg;
  
  Enemy(int x, int y, int type) {
    this.x = x;
    this.y = y;
    this.type = type;
    enemyImg = loadImage("img/enemy.png");
    		
  }
  void move() {
    this.x+= 5;	
  }
 
  void draw(){
    image(enemyImg, x, y);
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

}

void addEnemy(int type){	
  for (int i = 0; i < enemyCount; ++i) {
    enemys[i] = null;
    bosses[i] = null;
  }
  switch (type) {
    case EnemysShowingType.STRAIGHT:
      addStraightEnemy();
      break;
    case EnemysShowingType.SLOPE:
      addSlopeEnemy();
      break;
    case EnemysShowingType.DIAMOND:
      addDiamondEnemy();
      break;
    case EnemysShowingType.STRONGLINE:
      addEnemyStrong();
    break;
  }
  time = millis();
}

void addStraightEnemy()
{
	float t = random(height - 60);
	int h = int(t);
	for (int i = 0; i < 5; ++i) {
		enemys[i] = new Enemy( (i+1)*-80, h , FlightType.ENEMY);
	}
}
void addSlopeEnemy()
{
	float t = random(height - 60 * 5);
	int h = int(t);
	for (int i = 0; i < 5; ++i) {
		enemys[i] = new Enemy((i+1)*-80, h + i * 50 , FlightType.ENEMY);
	}
}
void addDiamondEnemy()
{
	float t = random( 60 * 3 ,height - 60 * 3);
	int h = int(t);
	int x_axis = 1;
	for (int i = 0; i < 8; ++i) {
		if (i == 0 || i == 7) {
			enemys[i] = new Enemy((x_axis+1)*-80, h, FlightType.ENEMY);
			x_axis++;
		}
		else if (i == 1 || i == 5){
			enemys[i] = new Enemy((x_axis+1)*-80, h + 1 * 40, FlightType.ENEMY);
			enemys[i+1] = new Enemy((x_axis+1)*-80, h - 1 * 40, FlightType.ENEMY);
			i++;
			x_axis++;
			
		}
		else {
			enemys[i] = new Enemy((x_axis+1)*-80, h + 2 * 40, FlightType.ENEMY);
			enemys[i+1] = new Enemy((x_axis+1)*-80, h - 2 * 40, FlightType.ENEMY);
			i++;
			x_axis++;
		}
	}
}

void addEnemyStrong(){
  for (int i = 0; i < 5; ++i) {
    bosses[i] = new Boss(0, 40+ i * 85, FlightType.ENEMYSTRONG);
  }
}



