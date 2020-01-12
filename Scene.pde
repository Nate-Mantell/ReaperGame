enum PlayMode {
  BIRDSEYE,
  SIDESCROLL
}


class Scene {
  
  PVector position;
  
  Map map;
  
  Animation[] playerAnimations;
  
  Player player1;
  
  int viewW;
  int viewH;
  
  boolean changed;
  
  PlayMode mode; 
  
  Scene(Animation[] iplayerAnimations, Map imap, int scrW, int scrH) {
    position = new PVector(0,0);
    playerAnimations = iplayerAnimations;
    map = imap;
    viewW = scrW;
    viewH = scrH;
    
    changed = false;
    
    mode = PlayMode.SIDESCROLL;
    
    buildPlayer1();
  }
  
  void buildPlayer1() {
     
     ArrayList<Sprite> p1Sprites = new ArrayList<Sprite>();
     p1Sprites.add(new Sprite(playerImg[0],new PVector(0,0,0),64,64,true));
     
     player1 = new Player(map.playerInitialPosition,10,10,0,10,new Weapon(),p1Sprites,new Collider(0,0,32,10,0), this);
       
  }
  
  
  void step() {
    switch(mode) {
      case BIRDSEYE:
        player1.step();
      break;
      case SIDESCROLL:
        player1.step();
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
  
  void sceneDidChange() {
    changed = true;
  }
  
  void sceneFinishedDisplayingChanges() {
    changed = false;
  }
}
