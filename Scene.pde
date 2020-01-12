enum PlayMode {
  BIRDSEYE,
  SIDESCROLL
}


class Scene {
  
  PVector position;
  
  Map map;
  
  Animation[] playerAnimations;
  
  Player player1;
  
  PVector playerInitialPosition;
  
  GameObjectFactory gameObjectFactory;
  
  int viewW;
  int viewH;
  
  boolean changed;
  
  PlayMode mode; 
  
  ArrayList<Collision> collisions; 
  
  
  Scene(Animation[] iplayerAnimations, GameObjectFactory igameObjectFactory, Map imap, int scrW, int scrH) {
    position = new PVector(0,0);
    playerAnimations = iplayerAnimations;
    
    gameObjectFactory = igameObjectFactory;
    
    map = imap;
    viewW = scrW;
    viewH = scrH;
    
    changed = false;
    
    mode = PlayMode.SIDESCROLL;
    
    
    playerInitialPosition = new PVector(0,0,0);
    
    buildPlayer1();
  }
  
  void buildPlayer1() {
     
     ArrayList<Sprite> p1Sprites = new ArrayList<Sprite>();
     p1Sprites.add(new Sprite(playerImg[0],new PVector(0,0,0),64,64,true));
     
     player1 = new Player(playerInitialPosition,10,10,0,10,new Weapon(),p1Sprites,new Collider(0,0,32,10,0), this);
       
  }
  
  
  void step() {
    switch(mode) {
      case BIRDSEYE:
        player1.step();
      break;
      case SIDESCROLL:
      
        player1.step();
      
      
        //check if the player or enemies collide with game objects
        for(int i = 0; i < gameObjectFactory.gameObjects.size(); i++) {
           collisions = player1.footCollider.collide(gameObjectFactory.gameObjects.get(i).curCollider);
           
           if(collisions.size() > 0) {
              switch(gameObjectFactory.gameObjects.get(i).collisionEffect) {
                case BLOCK:
                  player1.addPos(-player1.vx*2,-player1.vy*2,0);
                  player1.stop();
                  
                break;
                case OBTAIN:
                  if(gameObjectFactory.gameObjects.get(i).consume() == true) {
                    //sceneScript.itemConsumed(gameObjectFactory.gameObjects.get(i));
                    gameObjectFactory.gameObjects.remove(i);
                    i--;
                  }
                continue;
                case DAMAGE:
                break;
                case SLOW:
                break;
                case TELEPORT:
                break;
                case ACTIVATE:
                break;
                case UNLOCK:
                break;
              }
              
              
           }
           
           /*
           for(int j = 0; j < enemyFactory.enemies.size(); j++) {
             collisions = enemyFactory.enemies.get(j).curCollider.collide(gameObjectFactory.gameObjects.get(i).curCollider);
           
             if(collisions.size() > 0) {
                switch(gameObjectFactory.gameObjects.get(i).collisionEffect) {
                  case BLOCK:
                    collisions.get(0).determineDirection();
                  
                    enemyFactory.enemies.get(j).addPos(-enemyFactory.enemies.get(j).vx*2,-enemyFactory.enemies.get(j).vy*2,0);
                    enemyFactory.enemies.get(j).stop();
                    
                    enemyFactory.enemies.get(j).respondToBarrier(collisions.get(0));
                  break;
                  case DAMAGE:
                  break;
                  case SLOW:
                  break;
                  default:
                  break;
                }
             }
           }
           */
           
        }
      
      
      break;
    }
    sceneDidChange();
  }
  
  void animate() {
    for(int i = 0; i < playerAnimations.length; i++) {
      playerAnimations[i].animate();
    }
    
    sceneDidChange();
  }
  
  void display() {
    switch(mode) {
      case BIRDSEYE:
        player1.display(position);
      break;
      
      case SIDESCROLL:
        
        
        centerOnPlayer(player1);
        constrainToMapBoundaries(map);
        
        player1.display(position);
        
        
        
      break;
    }
  }
  
  void centerOnPlayer(Player p) {
    position.x = p.position.x - width/2;
    position.y = p.position.y - height/2;
  }
  
  void constrainToMapBoundaries(Map m) {
    if(position.x < m.leftBoundary()) 
      position.x = m.leftBoundary();
      
    if(position.y < m.upperBoundary()) 
      position.y = m.upperBoundary();
      
    if(position.x > m.rightBoundary()-width) 
      position.x = m.rightBoundary()-width;
      
    if(position.y > m.lowerBoundary()-height) 
      position.y = m.lowerBoundary()-height;
    
  }
  
  void buttonPressedUp() {
    
  }
  
  void buttonReleasedUp() {
    
  }
  
  void buttonPressedDown() {
    
  }
  
  void buttonReleasedDown() {
    
  }
  
  void buttonPressedRight() {
    player1.walkRight();
  }
  
  void buttonReleasedRight() {
    player1.vx = 0;
  }
  
  void buttonPressedLeft() {
    player1.walkLeft();
  }
  
  void buttonReleasedLeft() {
    player1.vx = 0;
  }
  
  void buttonPressedStop() {
    
  }
  
  
  void spawnPlayerBullet(PVector playerPosition, Weapon w) {
    
  }
  
  
  void loadLevel(String fname) {
    JSONObject objMaster = loadJSONObject(fname);
    
    JSONObject obj = objMaster.getJSONObject("player");
    playerInitialPosition = new PVector(obj.getFloat("x"),obj.getFloat("y"),obj.getFloat("z"));
    
    player1.move(playerInitialPosition);
      
    JSONArray array = objMaster.getJSONArray("gameObjects");
    gameObjectFactory.loadGameObjects(array);
      
    map.loadMap(objMaster);
    
  }
  
  
  void sceneDidChange() {
    changed = true;
  }
  
  void sceneFinishedDisplayingChanges() {
    changed = false;
  }
}
