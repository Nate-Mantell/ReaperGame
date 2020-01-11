class Weapon {
 
  String name;
  int type;
  int mp;
  int damage;
  int soundEffect;
  int upCost, upMP;
  Animation boltAnimation;
  
  Weapon() {
     upCost = 0;
     upMP = 0;
     mp = 0;
     damage=0;
     soundEffect=0;
     boltAnimation = null;
     name = "NULL";
  }
  
}

class WeaponFactory {
  Animation[] playerWeapBoltImg;
  Animation[] enemyWeapBoltImg;
  
  WeaponFactory(Animation[] iplayerWeapBoltImg, Animation[] ienemyWeapBoltImg) {
    
    playerWeapBoltImg = iplayerWeapBoltImg;
    enemyWeapBoltImg = ienemyWeapBoltImg;
    
  }  
  
  Weapon createWeapon(int itype) {
    Weapon w = new Weapon();
    
    w.type = itype;
    
    switch(itype) {
      default:
      case 1:
        w.upCost = 0;
        w.upMP = 0;
        w.mp = 0;
        w.damage=1;
        w.soundEffect=1;
        w.boltAnimation = playerWeapBoltImg[0];
        w.name = "Whirl Blaster";
      break;  
      case 2:
        w.upCost = 5;
        w.upMP = 8;
        w.mp = 1;
        w.damage=2;
        w.soundEffect=2;
        w.boltAnimation = playerWeapBoltImg[1];
        w.name = "Energy Ball";
      break;
    }
    
    return w;
  }
  
}


class WeaponBolt {
  ArrayList<Sprite> sprites;
  Sprite curSprite;
  int type;
  int damage;
  float x,y,z,vx,vy,vz;
  boolean active;
  
  Collider curCollider;
  
  
  WeaponBolt(float ix, float iy, float iz, float ivx, float ivy, float ivz, Weapon iw) {
    active = true;
    type=iw.type;
    damage = iw.damage;
    x=ix;y=iy;z=iz;
    vx=ivx;vy=ivy;vz=ivz;
    sprites = new ArrayList<Sprite>();
    
    switch(type) {
      default:
      case 1:
        sprites.add(new Sprite(iw.boltAnimation,new PVector(x,y,z),10,10,true));
      break;
      
      
    }
    
    curSprite = sprites.get(0);
    
    curCollider = new Collider(x,y,x+curSprite.w,y+curSprite.h,z);
  }
  
  void display(float xOff,float yOff) {
    sprites.get(0).pos.x=x;
    sprites.get(0).pos.y=y;
    sprites.get(0).pos.z=z;
    sprites.get(0).display(xOff,yOff);
  }
  
  void step() {
    x+=vx;
    y+=vy;
    z+=vz;
    
    updateColliderPos();
  }
  
  void animate() {
    sprites.get(0).animate();
    curSprite = sprites.get(0);
  }
  
  void reset(float ix, float iy, float iz, float ivx, float ivy, float ivz, Weapon iw) {
    active = true;
    type=iw.type;
    damage = iw.damage;
    x=ix;y=iy;z=iz;
    vx=ivx;vy=ivy;vz=ivz;
    sprites.clear();
    
    switch(type) {
      default:
      case 1:
        sprites.add(new Sprite(iw.boltAnimation,new PVector(x,y,z),10,10,true));
      break;
      
      
    }
    
    curSprite = sprites.get(0);
    updateColliderPos();
    
  }
  
  void updateColliderPos() {
    curCollider.updatePosition(x,y,x+curSprite.w,y+curSprite.h,z);
  }
  
  void destroy() {
    
    //TODO: display an explosion first before it is destroyed
    active=false;
  }
  
  
}

class WeaponBoltFactory {
  ArrayList<WeaponBolt> weaponBolts;
  
  WeaponBoltFactory() {
    weaponBolts = new ArrayList<WeaponBolt>();
  }
  
  WeaponBolt createWeaponBolt(float ix, float iy, float iz, float ivx, float ivy, float ivz, Weapon iw) {
    //TODO: Pool animations as well as sprites
    
    for(int i = 0; i < weaponBolts.size(); i++) {
      if(!weaponBolts.get(i).active) {
        //weaponBolts.get(i).active=true;
        //weaponBolts.get(i).x = ix;
        //weaponBolts.get(i).y = iy;
        //pweaponBolts.get(i).z = iz; 
        //weaponBolts.get(i).vx = ivx;
        //weaponBolts.get(i).vy = ivy;
        //weaponBolts.get(i).vz = ivz; 
        //weaponBolts.get(i).type = itype;
        weaponBolts.get(i).reset(ix,iy,iz,ivx,ivy,ivz,iw);
        //TODO: Change animation if type changes
        
        return weaponBolts.get(i);
      }
    }
    
    weaponBolts.add(new WeaponBolt(ix, iy, iz, ivx, ivy, ivz, iw));
    return weaponBolts.get(weaponBolts.size()-1);
  }
}
