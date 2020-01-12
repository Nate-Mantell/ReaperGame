static enum GameObjectEffect {
  BLOCK,
  OBTAIN,
  DAMAGE,
  SLOW,
  TELEPORT,
  ACTIVATE,
  UNLOCK
}


class GameObject {
  ArrayList<Sprite> sprites;
  Sprite curSprite;
  
  Collider curCollider;
  
  int type;
  GameObjectEffect collisionEffect;
  String id;
  
  float x,y,z;
  
  boolean active; // for use with the object pool only
  
  boolean consumable; // if true, it takes effect when touched
  
  long lastTime,timer;
  
  GameObject(float ix, float iy, float iz, int itype, GameObjectEffect ice, ArrayList<Sprite> isp) {
    x=ix;y=iy;z=iz;
    
    type = itype;
    sprites=isp;
    curSprite = sprites.get(0);
    
    
    curCollider = new Collider(x,y,x+curSprite.w,y+curSprite.h,z);
    
    
    collisionEffect=ice;
    
    active=true;
    consumable = true;
    
    lastTime = 0;
    timer = 0;
    
    id = generateID();
    
    
  }
  
  void display(float xOff, float yOff) {
    
    curSprite = sprites.get(0);
    curSprite.pos.set(x,y,z);
    curSprite.display(xOff,yOff);
  }
  
  void display(float xOff, float yOff, float wScaled, float hScaled) {
    
    curSprite = sprites.get(0);
    curSprite.pos.set(x,y,z);
    curSprite.display(xOff,yOff,wScaled,hScaled);
  }
  
  void animate() {
    sprites.get(0).animate();
  }
  
  void step() {
    
    //collision map
    
    
  }
  
  void updateColliderPos() {
    curCollider.updatePosition(x,y,x+curSprite.w,y+curSprite.h,z);
  }
  
  void activate() {
    
  }
  
  void unconsumable(long t) {
    consumable = false;
    timer = t;
    lastTime = millis();
    
  }
  
  boolean isConsumable() {
    if(consumable == true) return true;
    if(millis() - lastTime > timer) {
      consumable = true;
      return true;
    } else {
      return false;
    }
  }
  
  boolean consume() {
    
    if(!isConsumable()) return false;
    
    switch(type) {
      //Health Potion
      case 3:
        //soundEffects.itemEffects.get(4).play();
        player1.restoreHP(5);
        return true;
        
    }
    
    return false;
  }
  
  
  String name() {
    return gameObjectFactory.objectName(type);
  }
  
  String description() {
    return gameObjectFactory.objectDescription(type);
  }
  
  String generateID() {
    char[] str = new char[20];
    for(int i = 0; i < str.length; i++) {
      str[i] = (char)(random(85)+41);
    }
  
    return new String(str);
  }
  
  void pairID(GameObject o) {
    id = o.id;
  }
  
}


/////// Game Object Factory ////////////
class GameObjectFactory {
  String[][] objectDescriptions = {
    {"Barrier","Blocks a player or enemy"},
    {"Finish Block","Use as trigger to finish a level"},
    {"Health Potion","Restore 5 health points"}
  };
  
  ArrayList<GameObject> gameObjects;
  
  Animation[] itemImg;
  
  GameObjectFactory(Animation[] iitemImg) {
    gameObjects = new ArrayList<GameObject>();
    
    itemImg = iitemImg;
  }
  
  void clear() {
    gameObjects.clear();
  }
  
  GameObject createObject(float ix, float iy, float iz, int itype, GameObjectEffect ice, ArrayList<Sprite> isp) {
    //TODO: Pool animations as well as sprites
    
    for(int i = 0; i < gameObjects.size(); i++) {
      if(!gameObjects.get(i).active) {
        gameObjects.get(i).active=true;
        gameObjects.get(i).consumable=true;
        gameObjects.get(i).lastTime=0;
        gameObjects.get(i).timer=0;
        gameObjects.get(i).x = ix;
        gameObjects.get(i).y = iy;
        gameObjects.get(i).z = iz; 
        gameObjects.get(i).type = itype;
        gameObjects.get(i).collisionEffect=ice;
        gameObjects.get(i).sprites = isp;
        //TODO: Change animation and reset special variables if type changes
        
        return gameObjects.get(i);
      }
    }
    
    gameObjects.add(new GameObject(ix, iy, iz, itype, ice, isp));
    return gameObjects.get(gameObjects.size()-1);
  }


  GameObject createObject(float ix, float iy, float iz, int itype) {
    ArrayList<Sprite> gOSpList;
  
    gOSpList = new ArrayList<Sprite>();
  
    switch(itype) {
      default:
      case 1:
        //invisible barrier (for the map)
        gOSpList.add(new Sprite(itemImg[0], new PVector(ix, iy, iz), itemImg[0].images[0].width, itemImg[0].images[0].height, false));
        return this.createObject(ix, iy, iz, itype, GameObjectEffect.BLOCK, gOSpList);
      case 2:
        //Finish Block
        gOSpList.add(new Sprite(itemImg[0], new PVector(ix, iy, iz), itemImg[0].images[0].width, itemImg[0].images[0].height, false));
        return this.createObject(ix, iy, iz, itype, GameObjectEffect.OBTAIN, gOSpList);
      case 3:
        //Health Potion
        gOSpList.add(new Sprite(itemImg[2], new PVector(ix, iy, iz), itemImg[2].images[0].width, itemImg[2].images[0].height, true));
        return this.createObject(ix, iy, iz, itype, GameObjectEffect.OBTAIN, gOSpList);
      
        
    }
  }
  
  void displayBarriers() {
    for(int i = 0; i<gameObjects.size(); i++) {
      if(gameObjects.get(i).type == 1) {
         gameObjects.get(i).curSprite.visible=true;
      }
    }
  }
  
  void hideBarriers() {
    for(int i = 0; i<gameObjects.size(); i++) {
      if(gameObjects.get(i).type == 1) {
         gameObjects.get(i).curSprite.visible=false;
      }
    }
  }
  
  String objectName(int type) {
    return this.objectDescriptions[type-1][0];
  }
  
  String objectDescription(int type) {
    return this.objectDescriptions[type-1][1];
  }
  
  void loadGameObjects(JSONArray array) {
    
    JSONObject obj; 
    
    for(int i = 0; i < array.size(); i++) {
      obj = array.getJSONObject(i);
      this.createObject(obj.getInt("x"), obj.getInt("y"), obj.getInt("z"), obj.getInt("type"));
    }
    
  }
  
}
