
class Scene {
  
  PVector position;
  
  Map map;
  
  Animation[] playerAnimations;
  
  Player player1;
  
  int viewW;
  int viewH;
  
  Scene(Animation[] iplayerAnimations, Map imap, int scrW, int scrH) {
    position = new PVector(0,0);
    playerAnimations = iplayerAnimations;
    map = imap;
    viewW = scrW;
    viewH = scrH;
  }
  
  
  void step() {
    for(int i = 0; i < playerAnimations.length; i++) {
      playerAnimations[i].animate();
    }
    
  }
  
  void display() {
    map.display(position);
    player1.display(position);
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
  
  void scrollUp() {
    
  }
  
  void scrollDown() {
    
  }
  
  void scrollRight() {
    
  }
  
  void scrollLeft() {
    
  }
  
  void stopScrolling() {
    
  }
  
  
  void spawnPlayerBullet(PVector playerPosition, Weapon w) {
    
  }
  
  
}
