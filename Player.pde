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
  
  PhysicalObject physobject;
  
  float acc,baseacc, arv;
  
  PVector baseFriction;
  
  int dx,dy;
  
  boolean sidescroll;
  
  
  Player(PVector ipos, int ihp, int imhp, int imp, int immp, Weapon iweap, ArrayList<Sprite> isp, Collider ifootCollider, Scene iscene) {
    scene = iscene;
    
    physobject = new PhysicalObject(ipos);
    
    acc = 1; baseacc = 1; 
    arv = 0;
    
    baseFriction = new PVector(0.8,0.96,0.8);
    
    
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
    
    
    
    curCollider = new Collider(physobject.position.x,physobject.position.y,
                               physobject.position.x+curSprite.w,physobject.position.y+curSprite.h,physobject.position.z);
    
    
    //foot collider w=32,h=10
    footH = 10;
    
    footCollider = ifootCollider;
    footCollider.setcx1(physobject.position.x);
    footCollider.setcy1(physobject.position.y+curSprite.h-footH);
    footCollider.setcx2(physobject.position.x+curSprite.w);
    footCollider.setcy2(physobject.position.y+curSprite.h);
    footCollider.setz(0);
  }
  
  PVector position() {
    return physobject.position;
  }
  
  void walkRight() {
    if(state == 2) return;
    //vx = acc+arv;
    addForce(new Force(new PVector((acc+arv),0,0),baseFriction));
    //vy = 0;
    dx = 1;
    dy = 0;
    
    curSprite = sprites.get(0);
  }
  
  void runRight() {
    if(state == 2) return;
    //vx = acc*2+arv;
    addForce(new Force(new PVector((acc*2+arv),0,0),baseFriction));
    //vy = 0;
    dx = 1;
    dy = 0;
    
    curSprite = sprites.get(0);
  }
  
  void walkLeft() {
    if(state == 2) return;
    //vx = -(acc+arv);
    addForce(new Force(new PVector(-(acc+arv),0,0),baseFriction));
    //vy = 0;
    dx = -1;
    dy = 0;
    
    curSprite = sprites.get(1);
  }
  
  void runLeft() {
    if(state == 2) return;
    //vx = -(acc*2+arv);
    addForce(new Force(new PVector(-(acc*2+arv),0,0),baseFriction));
    //vy = 0;
    dx = -1;
    dy = 0;
    
    curSprite = sprites.get(1);
  }
  
  void walkUp() {
    /*
    if(state == 2) return;
    physobject.velocity.x = 0;
    physobject.velocity.y = -(acc+arv);
    dx = 0;
    dy = -1;
    */
  }
  
  void runUp() {
    /*
    if(state == 2) return;
    physobject.velocity.x = 0;
    physobject.velocity.y = -(acc*2+arv);
    dx = 0;
    dy = -1;
    */
  }
  
  void walkDown() {
    /*
    if(state == 2) return;
    physobject.velocity.x = 0;
    physobject.velocity.y = acc+arv;
    dx = 0;
    dy = 1;
    */
  }
  
  void runDown() {
    /*
    if(state == 2) return;
    physobject.velocity.x = 0;
    physobject.velocity.y = acc*2+arv;
    dx = 0;
    dy = 1;
    */
  }
  
  void stop() {
    physobject.velocity.x = 0;
    physobject.velocity.y = 0;
  }
  
  void jump() {
    if(state == 2) return;
    //soundEffects.playerEffects.get(1).play();
    
    if(sidescroll) {
      if(physobject.velocity.y >= -0.5 && physobject.velocity.y <= 0.5) {
        //vy = -acc*5;
        addForce(new Force(new PVector(0, -acc*5, 0),baseFriction));
      }
    } else {
      if(physobject.position.z == 0) physobject.velocity.z = acc*5;
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
    /*
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
    */
    
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
    scene.spawnPlayerBullet(physobject.position,weapon);
  }
  
  void step() {
    
    checkState();
    
    //resolve all the forces applied this step to get the resultant change to velocity
    resolveForces();
    
    //update position with velocity
    physobject.applyVelocityToPosition();
    
    
    //gravity for jumping, ground collision, and friction
    if(sidescroll) {
      //if(vy < -0.5) {
        //vy+=0.5;
      //} else {
      //  vy = 0;
      //}
      
      addForce(new Force(new PVector(0,0.5,0),baseFriction));
      
      
    } else {
      if(physobject.position.z > 0) {
        physobject.velocity.z-=0.5;
      } else {
        physobject.position.z = 0;
        physobject.velocity.z = 0;
      }
    }
    
    
    //update the Sprites' positions now that the physical attributes have been updated
    updateSpritePos();
    
    updateColliderPos();
    
  }
  
  void addForce(Force f) {
    physobject.addForce(f);
  }
  
  
  void resolveForces() {
    physobject.resolveForces();
  }
  
  PVector projectedVelocity() {
    return physobject.projectedVelocity();
  }
  
  /*
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
  }*/
  
  /*
  void bounce(ArrayList<Collision> collisions, float bfrictionx, float bfrictiony) {
    switch(collisions.get(0).determineDirection()) {
      case C_BOTTOM:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfrictiony;
        break;
      case C_LOWER_RIGHT:
        vy = -abs(vy) * bfrictiony;
        vx = -abs(vx) * bfrictionx;
        break;
      case C_LOWER_LEFT:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        vy = -abs(vy) * bfrictiony;
        vx = abs(vx) * bfrictionx;
        break;
      case C_RIGHT:
        vx = -abs(vx) * bfrictionx;
        break;
      case C_LEFT:
        vx = abs(vx) * bfrictionx;
        break;
      case C_TOP:
        vy = abs(vy) * bfrictiony;
        break;
      case C_UPPER_RIGHT:
        vy *= abs(vy) * bfrictiony;
        vx = -abs(vx) * bfrictionx;
        break;
      case C_UPPER_LEFT:
        vy *= abs(vy) * bfrictiony;
        vx = abs(vx) * bfrictionx;
        break;
      case C_UNKNOWN:
        break;
    }
    
    updateColliderPos();
  }
  */
  
  /*
  void bounce(ArrayList<Collision> collisions, float bfrictionx, float bfrictiony) {
    PVector pv = projectedVelocity();
    
    Collision c = collisions.get(0);
    switch(c.determineDirection()) {
      case C_BOTTOM:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        //vy = -abs(vy) * bfrictiony;
        addForce(new PVector(-abs(pv.y)-(c.a.cy2-c.b.cy1),0));
        break;
      case C_LOWER_RIGHT:
        //vy = -abs(vy) * bfrictiony;
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x)-(c.a.cx2-c.b.cx1),-abs(pv.y)-(c.a.cy2-c.b.cy1),0));
        break;
      case C_LOWER_LEFT:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        //vy = -abs(vy) * bfrictiony;
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x)+(c.b.cx2-c.a.cx1),-abs(pv.y)-(c.a.cy2-c.b.cy1),0));
        break;
      case C_RIGHT:
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x)-(c.a.cx2-c.b.cx1),0,0));
        break;
      case C_LEFT:
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x)+(c.b.cx2-c.a.cx1),0,0));
        break;
      case C_TOP:
        //vy = abs(vy) * bfrictiony;
        addForce(new PVector(abs(pv.y)+(c.b.cy2-c.a.cy1),0));
        break;
      case C_UPPER_RIGHT:
        //vy *= abs(vy) * bfrictiony;
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x)-(c.a.cx2-c.b.cx1),abs(pv.y)+(c.b.cy2-c.a.cy1),0));
        break;
      case C_UPPER_LEFT:
        //vy *= abs(vy) * bfrictiony;
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x)+(c.b.cx2-c.a.cx1),abs(pv.y)+(c.b.cy2-c.a.cy1),0));
        break;
      case C_UNKNOWN:
        break;
    }
    
    updateColliderPos();
  }
  */
  
  /*
  void bounce(ArrayList<Collision> collisions, float bfrictionx, float bfrictiony) {
    PVector pv = projectedVelocity();
    
    Collision c = collisions.get(0);
    switch(c.determineDirection()) {
      case C_BOTTOM:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        //vy = -abs(vy) * bfrictiony;
        addForce(new PVector(-abs(pv.y),0));
        break;
      case C_LOWER_RIGHT:
        //vy = -abs(vy) * bfrictiony;
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x),-abs(pv.y),0));
        break;
      case C_LOWER_LEFT:
        //position.y = collisions.get(0).b.cy1 - (curCollider.cy2-curCollider.cy1);
        //vy = -abs(vy) * bfrictiony;
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x),-abs(pv.y),0));
        break;
      case C_RIGHT:
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x),0,0));
        break;
      case C_LEFT:
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x),0,0));
        break;
      case C_TOP:
        //vy = abs(vy) * bfrictiony;
        addForce(new PVector(abs(pv.y),0));
        break;
      case C_UPPER_RIGHT:
        //vy *= abs(vy) * bfrictiony;
        //vx = -abs(vx) * bfrictionx;
        addForce(new PVector(-abs(pv.x),abs(pv.y),0));
        break;
      case C_UPPER_LEFT:
        //vy *= abs(vy) * bfrictiony;
        //vx = abs(vx) * bfrictionx;
        addForce(new PVector(abs(pv.x),abs(pv.y),0));
        break;
      case C_UNKNOWN:
        break;
    }
    
    //updateColliderPos();
  }
  */
  
  
  void bounceLine(ArrayList<LineCollision> collisions, float bfrictionx, float bfrictiony) {
    PVector pv = projectedVelocity();
    
    LineCollision c = collisions.get(0);
    
    /*float cdx = 0, cdy = 0;
    
    if(pv.x > 0) {
      cdx = -1;
    } else {
      cdx = 1;
    }
    
    if(pv.y > 0) {
      cdy = -1;
    } else {
      cdy = 1;
    }*/
    
    //PVector ln = c.b.getNormalVector(CollisionLineDirection.UP);
    //addForce(new PVector(abs(pv.x*ln.x),abs(pv.y*ln.y),0));
    
    if(c.b.isHorizontal(50)) {
      if(pv.y > 0) {
        Force f = new Force(new PVector(0,-pv.y-(c.a.cy2-c.b.getYatX((c.a.cx2-c.a.cx1)/2)),0));
        //if(abs(f.acceleration.x) < abs(pv.x)-0.1 || abs(f.acceleration.x) > abs(pv.x)+0.1 ) {
        //    print("BounceY B PV=("+pv.x+","+pv.y+"), CAY1:"+c.a.cy1+
        //          " CAY2:"+c.a.cy2+" CBAY:"+c.b.getYatX((c.a.cx2-c.a.cx1)/2)+
        //          ", OFFSY:"+(c.a.cy2-c.b.getYatX((c.a.cx2-c.a.cx1)/2))+"\n");
        //}
        addForce(f);
        /*print("PV=("+(pv.x)+","+(pv.y)+")"+
              " CY2="+(c.a.cy2)+
              " CX="+((c.a.cx2-c.a.cx1)/2)+
              " LineYatX="+(c.b.getYatX((c.a.cx2-c.a.cx1)/2))+
              " CF="+(c.a.cy2-c.b.getYatX((c.a.cx2-c.a.cx1)/2)));
        */
        //print("Added bounce force: " + f);
      }
    } else if(c.b.isVertical(50)) {
      if(pv.x < 0) {
        Force f = new Force(new PVector(-(pv.x+(c.a.cx1-c.b.a.x)),0,0),true);
        if(abs(f.acceleration.x) > abs(pv.x)) {
          print("BounceX L PV=("+pv.x+","+pv.y+"), CAX1:"+c.a.cx1+" CAX2:"+c.a.cx2+" CBAX:"+c.b.a.x+", OFFSX:"+(c.a.cx1-c.b.a.x)+"\n");
        }
        addForce(f);
      } else {
        Force f = new Force(new PVector(-(pv.x-(c.a.cx2-c.b.a.x)),0,0),true);
        if(abs(f.acceleration.x) > abs(pv.x)) {
          print("BounceX R PV=("+pv.x+","+pv.y+"), CAX1:"+c.a.cx1+" CAX2:"+c.a.cx2+" CBAX:"+c.b.a.x+", OFFSX:"+(c.a.cx2-c.b.a.x)+"\n");
        }
        addForce(f);
      }
    }
    
    //updateColliderPos();
  }
  
  /*
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
  */
  
  void addPos(float xAdd, float yAdd, float zAdd) {
    physobject.position.x+=xAdd;
    physobject.position.y+=yAdd;
    physobject.position.z+=zAdd;
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
    
    curSprite.pos.x = physobject.position.x;
    curSprite.pos.y = physobject.position.y;
    curSprite.pos.z = physobject.position.z;
    
  }
  
  void updateSpritePos(PVector offset) {
    
    curSprite.pos.x = physobject.position.x-offset.x;
    curSprite.pos.y = physobject.position.y-offset.y;
    curSprite.pos.z = physobject.position.z;
    
  }
  
  void updateColliderPos() {
    curCollider.updatePosition(physobject.position.x,physobject.position.y,
                               physobject.position.x+curSprite.w,physobject.position.y+curSprite.h,physobject.position.z);
    footCollider.updatePosition(physobject.position.x,physobject.position.y+curSprite.h-footH,
                                physobject.position.x+curSprite.w,physobject.position.y+curSprite.h,physobject.position.z);
  }
  
  
  void move(PVector newPosition) {
    physobject.position.set(newPosition);
    updateSpritePos();
  }
  
  void move(float mx, float my, float mz) {
    physobject.position.x = mx; physobject.position.y = my; physobject.position.z = mz;
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
  
  /*
  void changeSpeed(float newacc, int time) {
    absolveState();
    
    returnState = state;
    state = 3;
    stateTimer = time;
    
    acc = newacc;
    vx*= newacc;
    vy*= newacc;
  }
  */
  
  void absolveState() {
    stateTimer=0;
    checkState();
  }
  
  void checkState() {
    switch(state) {
      //damage
      case 2:
        /*
        vx*=0.8;
        //vy*=0.8;
        stateTimer--;
        if(stateTimer <= 0) {
          vx=0;
          //vy=0;
          state = returnState;
        }
        */
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
