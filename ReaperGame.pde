int programState;


Animation[] mapImg = new Animation[15];
Animation[] playerImg = new Animation[2];
Animation[] itemImg = new Animation[3];


TilePalette mapTilePalette;
Map map;


Player player1;


Scene scene;
Controls controls;

MapView mapView;


GameObjectFactory gameObjectFactory;


void setup() {
  size(600,800);
  
  //PFont font;
  //font = createFont("NightmarePills-BV2w.ttf",14);
  //textFont(font);
  
  mapImg[0] = new Animation("grass1",".png",1,0,false,false);
  mapImg[1] = new Animation("rocks1",".png",1,0,false,false);
  mapImg[2] = new Animation("rocks2",".png",1,0,false,false);
  mapImg[3] = new Animation("stone1",".png",1,0,false,false);
  mapImg[4] = new Animation("lava",".png",6,0,false,false);
  mapImg[5] = new Animation("sea",".png",3,0,false,false);
  mapImg[6] = new Animation("platform1",".png",1,0,false,false);
  mapImg[7] = new Animation("platform2",".png",1,0,false,false);
  mapImg[8] = new Animation("platform3",".png",1,0,false,false);
  mapImg[9] = new Animation("platform4",".png",1,0,false,false);
  mapImg[10] = new Animation("platform5",".png",1,0,false,false);
  mapImg[11] = new Animation("platform6",".png",1,0,false,false);
  mapImg[12] = new Animation("platform7",".png",1,0,false,false);
  mapImg[13] = new Animation("cave1",".png",1,0,false,false);
  mapImg[14] = new Animation("black1",".png",1,0,false,false);
  
  playerImg[0] = new Animation("Reaper_Walk_Right_64x64",".png",13,10,64,64,true,true);
  playerImg[1] = new Animation("Reaper_Walk_Left_64x64",".png",13,10,64,64,true,true);
  
  itemImg[0] = new Animation("ass1",".png",1,0,false,false);
  itemImg[1] = new Animation("ass1",".png",1,0,false,false);
  itemImg[2] = new Animation("item1",".png",5,30,true,true);
  
  mapTilePalette = new TilePalette(mapImg);
  map = new Map(50, 50, 32, 32, mapTilePalette);


  gameObjectFactory = new GameObjectFactory(itemImg);
  
  mapView = new MapView(map);
 
  scene = new Scene(playerImg, gameObjectFactory, map, width, height);
  controls = new Controls(width, height, scene);
 
  programState=1;
  thread("loadGame");
}


///// Asynchronous Load method for Loading Screen
void loadGame() {
  
  scene.loadLevel("BirdsEyeMap.json");
  
  mapView.compile();
  
  scene.mode = PlayMode.SIDESCROLL;
  programState = 2;
  
}


/////////////////State Update Method////
void updateModel() {
  
  scene.step();
}


void draw() {
 
 switch(programState) {
 
   case 2: //Sidescrolling Play Mode
     
     //Handle the UI and model
     controls.check();
   
     updateModel();
   
   
     //Handle the view
     if(scene.changed || mapView.changed) {
       background(0,0,0);
       mapView.display(int(scene.position.x),int(scene.position.y));
       scene.display();
       
       mapView.mapviewFinishedDisplayingChanges();
       scene.sceneFinishedDisplayingChanges();
     }
   
   
     scene.animate();
     mapView.animate();
   
   
     //Draw the controls overlay
     controls.display();
   
   
     //Set the scene back to static, unchanged state because we drew the previous changes
     scene.changed = false;
 
 
  break;
 
 
  case -1: //Debug View
     //map.displayMapFileDebug();
     break;
   
  case 1: //Loading Screen
  
     //displayLoadingScreen();
     
     break;
   
  case 3: //Game Over
     //displayGameOverScreen();
     break;
     
  case 4: //Exit Sequences such as level complete sequences
     //sceneScript.update();
     break;
   
  case 5: //Title Screen
     //displayTitleScreen();
     break;
  }
  
}
