
class MapView {
  
    int numFrames,frame;
    int framesPerSecond;
    long lastTime;
    ArrayList<PGraphics> vBuffer;
    boolean changed;
    
    int MapX, MapY, TileW, TileH;
    
    Map map;
    
    ArrayList<Sprite> gOSpList;
    
    MapView(Map imap) {
      numFrames=0;
      frame=0;
      framesPerSecond=12;
      lastTime=millis();
      changed=false;
      vBuffer = new ArrayList<PGraphics>();
      
      map = imap;
      MapX = map.sizeX;
      MapY = map.sizeY;
      TileW = map.tileW;
      TileH = map.tileH;
      
    }
    
    void compile() {
      
      //Display loading message
      //String loadtext = "LOADING MAP";
      //background(0,0,0);
      //textSize(64);
      //fill(128,256,128);
      //text(loadtext,ScrW/2-200,ScrH/2-32);
      
      //NOTE:All animations must have divisible number of frames to the greatest because we simply make frames = greatest frame count
      for(int i = 0; i<mapImg.length; i++) {
        if(mapImg[i].images.length > numFrames) {
          numFrames = mapImg[i].images.length;
        }
      }
      
      
      //Create a vBuffer of the entire map for each frame of animation
      for(int j=0; j<numFrames; j++) {
        vBuffer.add(createGraphics(MapX*TileW,MapY*TileH));
        
        vBuffer.get(j).beginDraw();
        for(int i = ((int(scene.position.y)/TileH)*MapX)+(int(scene.position.x)/TileW); 
            i < map.tiles.length
            && i < map.size();
            i++) {
  
            if(
                  (map.tiles[i] >= 0) 
               && (map.tiles[i] < mapImg.length) 

              ) {  
                  //if((i%MapX)*TileW-scene.viewX >= ScrW) {
                  //  i += ((MapX*TileW)-ScrW)/TileW-1;
                  //  continue;
                  //}
                  mapImg[map.tiles[i]].display((i%MapX)*TileW-scene.position.x, (i/MapX)*TileH-scene.position.y,vBuffer.get(j));
                  
                  
              }
         }
         vBuffer.get(j).endDraw();
         
         //Advance the frame for animations
         for(int i = 0; i < mapImg.length; i++) {
           mapImg[i].animate();
         }
         
         //Display loading message
         //loadtext = loadtext + ".";
         //background (0,0,0);
         //text(loadtext,ScrW/2-200,ScrH/2-32);
      }
      
      mapviewDidChange();
      
    }
    
    void display(int x, int y) {
   
      image(vBuffer.get(frame), -x, -y);
      
    }
    
    void animate() {
      if(int(millis()-lastTime) > 1000/framesPerSecond) {
        frame = (frame+1) % numFrames;
        lastTime = millis();
        mapviewDidChange();
      }
    }
    
    void mapviewDidChange() {
      changed = true;
    }
    
    void mapviewFinishedDisplayingChanges() {
      changed = false;
    }
}
