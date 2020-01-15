enum PlayMode {
  BIRDSEYE,
  SIDESCROLL
}

class PlayerAction {
   boolean WALKRIGHT,
   WALKLEFT,
   JUMP,
   ATTACK,
   USEITEM;
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
  
  boolean jumpLock;
  
  PlayMode mode; 
  
  CollisionLines collisionLines;
  
  ArrayList<Collision> collisions; 
  ArrayList<LineCollision> lineCollisions; 
  
  
  PlayerAction playerActions;
  
  
  Scene(Animation[] iplayerAnimations, GameObjectFactory igameObjectFactory, Map imap, int scrW, int scrH) {
    position = new PVector(0,0);
    playerAnimations = iplayerAnimations;
    
    gameObjectFactory = igameObjectFactory;
    
    collisionLines = new CollisionLines();
    
    map = imap;
    viewW = scrW;
    viewH = scrH;
    
    changed = false;
    
    jumpLock = false;
    
    mode = PlayMode.SIDESCROLL;
    
    playerActions = new PlayerAction();
    
    playerInitialPosition = new PVector(0,0,0);
    
    buildPlayer1();
    
    playerActions.WALKRIGHT=false;
    playerActions.WALKLEFT=false;
    playerActions.JUMP=false;
    playerActions.ATTACK=false;
    playerActions.USEITEM=false;
  }
  
  void buildPlayer1() {
     
     ArrayList<Sprite> p1Sprites = new ArrayList<Sprite>();
     p1Sprites.add(new Sprite(playerImg[0],new PVector(0,0,0),64,64,true));
     p1Sprites.add(new Sprite(playerImg[1],new PVector(0,0,0),64,64,true));
     
     player1 = new Player(playerInitialPosition,10,10,0,10,new Weapon(),p1Sprites,new Collider(0,0,32,10,0), this);
       
  }
  
  
  void step() {
    switch(mode) {
      case BIRDSEYE:
        player1.step();
      break;
      case SIDESCROLL:
      
        resolveControls();
        player1.step();
      
      
        for(CollisionLine line: collisionLines.lines) {
          lineCollisions = player1.footCollider.collide(line);
          
          if(lineCollisions.size() > 0) {
            player1.bounceLine(lineCollisions,1,0.001);
            
            controls.addMessage("Line Collision");
          }
        }
      
        //check if the player or enemies collide with game objects
        for(int i = 0; i < gameObjectFactory.gameObjects.size(); i++) {
           collisions = player1.footCollider.collide(gameObjectFactory.gameObjects.get(i).curCollider);
           
           if(collisions.size() > 0) {
              switch(gameObjectFactory.gameObjects.get(i).collisionEffect) {
                case BLOCK:
                  //player1.bounce(collisions,1,0.001); 
                  
                  //controls.addMessage(collisions.get(0).toString());
                  //TODO: give gameObject a bounciness value to use as the friction coefficient
                  //player1.stop();
                  
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
        
        for(CollisionLine line : collisionLines.lines) {
          stroke(255,0,0);
          line(line.a.x-position.x,line.a.y-position.y,line.b.x-position.x,line.b.y-position.y);
        }
        
        
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
    if(!jumpLock) {
      jumpLock=true;
      playerActions.JUMP=true;
    }
  }
  
  void buttonReleasedUp() {
    playerActions.JUMP=false;
    jumpLock=false;
  }
  
  void buttonPressedDown() {
    
  }
  
  void buttonReleasedDown() {
    
  }
  
  void buttonPressedRight() {
    playerActions.WALKRIGHT = true;
    
  }
  
  void buttonReleasedRight() {
    playerActions.WALKRIGHT = false;
    //player1.vx = 0;
  }
  
  void buttonPressedLeft() {
    playerActions.WALKLEFT = true;
  }
  
  void buttonReleasedLeft() {
    playerActions.WALKLEFT = false;
    //player1.vx = 0;
  }
  
  void buttonPressedStop() {
    
  }
  
  void resolveControls() {
      if(playerActions.WALKRIGHT) {
        player1.walkRight();
        controls.addMessage("walk right");
      }
      if(playerActions.WALKLEFT) {
        player1.walkLeft();
        controls.addMessage("walk left");
      }
      if(playerActions.JUMP) {
        player1.jump();
        playerActions.JUMP = false;
        controls.addMessage("jump");
      }
      if(playerActions.ATTACK) {
      
      }
      if(playerActions.USEITEM) {
      
      }
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
      
    array = objMaster.getJSONArray("collision_lines");
      
    collisionLines.load(array);
      
    map.loadMap(objMaster);
    
  }
  
  
  void sceneDidChange() {
    changed = true;
  }
  
  void sceneFinishedDisplayingChanges() {
    changed = false;
  }
}
