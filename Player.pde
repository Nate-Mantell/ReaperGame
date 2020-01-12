class Player {
  Scene scene;
  
  ArrayList<Sprite> sprites;
  Sprite curSprite;
  
  Collider footCollider;
  float footH;
  Collider curCollider;
  
  int hp,mhp, mp,mmp, ap,mxap;
  int currency;
  Weapon weapon;
  
  int state,returnState,stateTimer;
  PVector position;
  float vx,vy,vz, acc,baseacc, arv;
  
  PVector baseFriction, friction;
  
  int dx,dy;
  
  boolean sidescroll;
  
  Player(PVector ipos, int ihp, int imhp, int imp, int immp, Weapon iweap, ArrayList<Sprite> isp, Collider ifootCollider, Scene iscene) {
    scene = iscene;
    
    position = ipos;
    vx=0;vy=0;vz=0;
    acc = 1; baseacc = 1; 
    arv = 0;
    
    baseFriction = new PVector(0.8,0.96,0.8);
    friction = new PVector();
    friction.set(baseFriction);
    
    sidescroll = true;

    dx=0;dy=1;
    
    hp=ihp; mhp=imhp;
    mp=imp; mmp=immp;
    ap = 0; mxap = 0;
    
    currency = 0;
    
    weapon=iweap;
    
    sprites=isp;
    curSprite = sprites.get(0);
    
    state = 1;
    returnState = 1;
    stateTimer = 0;
    
    
    
    curCollider = new Collider(position.x,position.y,position.x+curSprite.w,position.y+curSprite.h,position.z);
    
    
    //foot collider w=32,h=10
    footH = 10;
    
    footCollider = ifootCollider;
    footCollider.setcx1(position.x);
    footCollider.setcy1(position.y+curSprite.h-footH);
    footCollider.setcx2(position.x+curSprite.w);
    footCollider.setcy2(position.y+curSprite.h);
    footCollider.setz(0);
  }
  
  void walkRight() {
    if(state == 2) return;
    vx = acc+arv;
    //vy = 0;
    dx = 1;
    dy = 0;
    
    curSprite = sprites.get(0);
  }
  
  void runRight() {
    if(state == 2) return;
    vx = acc*2+arv;
    //vy = 0;
    dx = 1;
    dy = 0;
    
    curSprite = sprites.get(0);
  }
  
  void walkLeft() {
    if(state == 2) return;
    vx = -(acc+arv);
    //vy = 0;
    dx = -1;
    dy = 0;
    
    curSprite = sprites.get(1);
  }
  
  void runLeft() {
    if(state == 2) return;
    vx = -(acc*2+arv);
    //vy = 0;
    dx = -1;
    dy = 0;
    
    curSprite = sprites.get(1);
  }
  
  void walkUp() {
    if(state == 2) return;
    vx = 0;
    vy = -(acc+arv);
    dx = 0;
    dy = -1;
  }
  
  void runUp() {
    if(state == 2) return;
    vx = 0;
    vy = -(acc*2+arv);
    dx = 0;
    dy = -1;
  }
  
  void walkDown() {
    if(state == 2) return;
    vx = 0;
    vy = acc+arv;
    dx = 0;
    dy = 1;
  }
  
  void runDown() {
    if(state == 2) return;
    vx = 0;
    vy = acc*2+arv;
    dx = 0;
    dy = 1;
  }
  
  void stop() {
    vx = 0;
    vy = 0;
  }
  
  void jump() {
    if(state == 2) return;
    //soundEffects.playerEffects.get(1).play();
    
    if(sidescroll) {
      if(vy >= -0.5 && vy <= 0.5) vy = -acc*5;
      friction.set(baseFriction);
    } else {
      if(position.z == 0) vz = acc*5;
    }
  }
  
  void damage(int damage, Collision c) {
    if(state == 2 || state == 4) return; //can't take damage while already being damaged or invincible
    int dv = 3;
    
       //type 1 = a lower right corner
       //type 2 = a upper right corner
       //type 3 = a upper left corner
       //type 4 = a lower left corner
       //type 5 = a bottom within b
       //type 6 = a top within b
       //type 7 = a right within b
       //type 8 = a left within b
    c.determineDirection();
    switch(c.type) {
      case C_UNKNOWN:
        //vx = -vx*3;
        //vy = -vy*3;
        break;
      case C_LOWER_RIGHT:
        vx = -dv;
        vy = -dv;
        break;
      case C_UPPER_RIGHT:
        vx = -dv;
        vy = dv;
        break;
      case C_UPPER_LEFT:
        vx = dv;
        vy = dv;
        break;
      case C_LOWER_LEFT:
        vx = dv;
        vy = -dv;
        break;
      case C_BOTTOM:
        //vx = -dv;
        vy = -dv;
        break;
      case C_TOP:
        //vx = -dv;
        vy = dv;
        break;
      case C_RIGHT:
        vx = -dv;
        //vy = -dv;
        break;
      case C_LEFT:
        vx = dv;
        //vy = -dv;
        break;
    }
    
    absolveState();
    returnState = state;
    state = 2;
    stateTimer = 10;
    
    if(ap > 0) {
      ap -= damage;
      if(ap <= 0) {
        //play armor destroy sound effect
        //soundEffects.itemEffects.get(11).play();
        curSprite = sprites.get(0);
        ap = 0;
        mxap = 0;
      } else {
        //soundEffects.playerEffects.get(0).play();
      }
    } else {
      hp -= damage;
      if(hp <= 0) {
        //soundEffects.playerEffects.get(2).play();
        hp = 0;
      } else {
        //soundEffects.playerEffects.get(0).play();
      }
    }
  }
  
  void attack() {
    //TODO: Impose a wait time in between shots based on weapon type
    if(state == 2) return;
    if(mp < weapon.mp) {
       //TODO: Play a failed shot sound effect
       //soundEffects.weaponEffects.get(13).play();
       return;
    }
    mp-=weapon.mp;
    scene.spawnPlayerBullet(position,weapon);
  }
  
  void step() {
    
    checkState();
    
    //update position with velocity
    position.x+=vx; position.y+=vy; position.z+=vz;
    
    
    //gravity for jumping, ground collision, and friction
    if(sidescroll) {
      //if(vy < -0.5) {
        vy+=0.5;
      //} else {
      //  vy = 0;
      //}
      
      vx *= friction.x;
      vy *= friction.y;
      vz *= friction.z;
    } else {
      if(position.z > 0) {
        vz-=0.5;
      } else {
        position.z = 0;
        vz = 0;
      }
    }
    
    //reset the friction after any ground and object frictions may have been applied
    friction.set(baseFriction);
    
    
    //update the Sprites' positions now that the physical attributes have been updated
    updateSpritePos();
    
    updateColliderPos();
    
  }
  
  void bounce(ArrayList<Collision> collisions, float bfriction) {
    switch(collisions.get(0).determineDirection()) {
      case C_BOTTOM:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfriction;
        break;
      case C_LOWER_RIGHT:
      case C_LOWER_LEFT:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfriction;
        vx *= -1 * bfriction;
        break;
      case C_RIGHT:
      case C_LEFT:
        vx *= -1 * bfriction;
        break;
      case C_TOP:
        vy = abs(vy) * bfriction;
        break;
      case C_UPPER_RIGHT:
      case C_UPPER_LEFT:
        vy *= abs(vy) * bfriction;
        vx *= -1 * bfriction;
        break;
      case C_UNKNOWN:
        break;
    }
    
    updateColliderPos();
  }
  
  
  void bounce(ArrayList<Collision> collisions, float bfrictionx, float bfrictiony) {
    switch(collisions.get(0).determineDirection()) {
      case C_BOTTOM:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfrictiony;
        break;
      case C_LOWER_RIGHT:
      case C_LOWER_LEFT:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfrictiony;
        vx = -vx;
        break;
      case C_RIGHT:
      case C_LEFT:
        vx = -vx;
        break;
      case C_TOP:
        vy = abs(vy) * bfrictiony;
        break;
      case C_UPPER_RIGHT:
      case C_UPPER_LEFT:
        vy *= abs(vy) * bfrictiony;
        vx = -vx;
        break;
      case C_UNKNOWN:
        break;
    }
    
    updateColliderPos();
  }
  
   void bounce(ArrayList<Collision> collisions) {
    switch(collisions.get(0).determineDirection()) {
      case C_BOTTOM:
        vy = -abs(vy);
        break;
      case C_TOP:
        vy *= -1;
        break;
      case C_LOWER_RIGHT:
      case C_LOWER_LEFT:
        vy *= -1;
        vx *= -1;
        break;
      case C_RIGHT:
      case C_LEFT:
        vx *= -1;
        break;
      case C_UPPER_RIGHT:
      case C_UPPER_LEFT:
        vy *= -1;
        vx *= -1;
        break;
      case C_UNKNOWN:
        break;
    }
  }
  
  void addPos(float xAdd, float yAdd, float zAdd) {
    position.x+=xAdd;
    position.y+=yAdd;
    position.z+=zAdd;
    updateSpritePos();
  }
  
  void display(PVector offset) {
    updateSpritePos(offset);
    curSprite.display();
  }
  
  void tint(int r, int g, int b) {
    curSprite.tint(r,g,b);
  }
  
  void noTint() {
    curSprite.noTint();
  }
  
  void animate() {
    curSprite.animate();
  }
  
  void updateSpritePos() {
    
    curSprite.pos.x = position.x;
    curSprite.pos.y = position.y;
    curSprite.pos.z = position.z;
    
  }
  
  void updateSpritePos(PVector offset) {
    
    curSprite.pos.x = position.x-offset.x;
    curSprite.pos.y = position.y-offset.y;
    curSprite.pos.z = position.z;
    
  }
  
  void updateColliderPos() {
    curCollider.updatePosition(position.x,position.y,position.x+curSprite.w,position.y+curSprite.h,position.z);
    footCollider.updatePosition(position.x,position.y+curSprite.h-footH,position.x+curSprite.w,position.y+curSprite.h,position.z);
  }
  
  
  void move(PVector newPosition) {
    position.set(newPosition);
    updateSpritePos();
  }
  
  void move(float mx, float my, float mz) {
    position.x = mx; position.y = my; position.z = mz;
    updateSpritePos();
  }
  
  void restoreHP(int value) {
    
    hp += value;
    if(hp > mhp) {
      hp = mhp;
    }
  }
  
  void addCurrency(int value) {
    currency += value;
  }
  
  void restoreMP(int value) {
    mp += value;
    if(mp > mmp) {
      mp = mmp;
    }
  }
   
  void addWeaponUpgrade() {
    
  }
  
  void invincible(int value) {
    absolveState();
    
    curSprite = sprites.get(1);
    returnState = state;
    state = 4;
    stateTimer = value;
  }
  
  void increaseMHP(int newmhp) {
    mhp += newmhp;
  }
  
  void increaseMMP(int newmmp) {
    mmp += newmmp;
  }
  
  void equipArmor(int newmxap, float iarv) {
    curSprite = sprites.get(2);
    mxap = newmxap;
    ap = mxap;
    arv = iarv;
  }
  
  void restoreAP() {
    absolveState();
    
    returnState = state;
    state = 5;
    stateTimer = mxap*10;
  }
  
  void incrementAP() {
    if(stateTimer % 10 == 0) {
      ap += 1;
      if(ap > mxap) {
        ap = mxap;
      }
    }
  }
  
  void changeSpeed(float newacc, int time) {
    absolveState();
    
    returnState = state;
    state = 3;
    stateTimer = time;
    
    acc = newacc;
    vx*= newacc;
    vy*= newacc;
  }
  
  void absolveState() {
    stateTimer=0;
    checkState();
  }
  
  void checkState() {
    switch(state) {
      //damage
      case 2:
        vx*=0.8;
        //vy*=0.8;
        stateTimer--;
        if(stateTimer <= 0) {
          vx=0;
          //vy=0;
          state = returnState;
        }
      break;
      //speed boosted
      case 3:
        stateTimer--;
        if(stateTimer <= 0) {
          acc = baseacc;
          state = returnState;
        }
      break;
      //invincible
      case 4:
        stateTimer--;
        if(stateTimer <= 0) {
          state = returnState;
          curSprite = sprites.get(0);
        }
      break;
      //armor
      case 5:
        incrementAP();
        stateTimer--;
        if(stateTimer <= 0) {
          state = returnState;
          curSprite = sprites.get(0);
        }
      break;
      
    }
  }
  
  
}
