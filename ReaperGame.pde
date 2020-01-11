int programState;


Animation[] mapImg = new Animation[15];
Animation[] playerImg = new Animation[3];
Animation[] enemyImg = new Animation[5];
Animation[] itemImg = new Animation[16];


TilePalette mapTilePalette;
Map map;


Player player1;


Scene scene;
Controls controls;

MapView mapView;



void setup() {
  size(600,600);
  
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
  
}

void draw() {
  
  
}
