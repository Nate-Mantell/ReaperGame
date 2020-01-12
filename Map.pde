
class Map {
  int sizeX, sizeY;
  int tileW, tileH;
  int[] tiles;
  
  PVector mapPosition;
  
  TilePalette mapTilePalette;
  
  Map(int isizeX, int isizeY,int itileW, int itileH, TilePalette imapTilePalette) {
    sizeX = isizeX; //50;
    sizeY = isizeY; //50;
    tileW = itileW; //32;
    tileH = itileH; //32;
    tiles = new int[sizeX*sizeY];
    
    mapPosition = new PVector(0,0);
    
    mapTilePalette = imapTilePalette;
  }
  
  void display(PVector offset) {
    for(int i = 0; i < tiles.length; i++) {
      image(mapTilePalette.palette[tiles[i]].currentFrame(),
            ((i%sizeX)*tileW)+(mapPosition.x-offset.x),
            ((i/sizeX)*tileH)+(mapPosition.y-offset.y));
      
    }
  }
  
  void moveUp(float velocity) {
    mapPosition.y += velocity;
  }
  
  void moveDown(float velocity) {
    mapPosition.y += velocity * -1;
  }
  
  void moveLeft(float velocity) {
    mapPosition.x += velocity;
  }
  
  void moveRight(float velocity) {
    mapPosition.x += velocity * -1;
  }
  
  int leftBoundary() {
    return int(mapPosition.x);
  }
  
  int upperBoundary() {
    return int(mapPosition.y);
  }
  
  int rightBoundary() {
    return int(mapPosition.x + (sizeX*tileW));
  }
  
  int lowerBoundary() {
    return int(mapPosition.y + (sizeY*tileH));
  }
  
 
  void loadMap(String fname) {
    JSONObject objMaster = loadJSONObject(fname);
    JSONArray array = objMaster.getJSONArray("map");
    JSONObject objTile;
    
    for(int i = 0; (i < array.size()) && (i < tiles.length); i++) {
      objTile = array.getJSONObject(i);
      tiles[i] = objTile.getInt("tile");
    }
    
    
  }
  
  void loadMap(JSONObject objMaster) {
    JSONArray array = objMaster.getJSONArray("map");
    JSONObject objTile;
    
    for(int i = 0; (i < array.size()) && (i < tiles.length); i++) {
      objTile = array.getJSONObject(i);
      tiles[i] = objTile.getInt("tile");
    }
    
  }
  
  int size() {
    return sizeX*sizeY;
  }
  
  
}
