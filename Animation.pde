class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  int fps;
  
  boolean trans,set;
  
  long lastTime;
  
  Animation(String[] imageNames, int iimageCount, int ifps) {
    fps = ifps;
    imageCount = iimageCount;
    frame = 0;
    lastTime = millis();
    
    images = new PImage[imageCount];
    
    for(int i = 0; i < imageCount; i++) {
      images[i] = loadImage(imageNames[i]);
    }
    
    trans = false;
    set = false;
    
  }
  
  Animation(String imagePrefix, String imageSuffix, int count, int ifps, boolean itrans, boolean set) { 
    //print("Loading " + imagePrefix + " " + imageSuffix + " " + count + "\n");
    fps=ifps;
    lastTime=millis();
    trans=itrans;
    imageCount = count; 
    images = new PImage[imageCount]; 
    if(imageCount == 1) {
      String filename = imagePrefix + imageSuffix;
      //print(filename+"\n");
      images[0] = loadImage(filename);
      
      //implement transparency, value of upper left pixel will be replaced with transparency
      if(trans) {
        color tc = images[0].pixels[0];
        for(int i = 0; i < images[0].pixels.length; i++) {
          if(tc == images[0].pixels[i]) {
            images[0].pixels[i] = color(0,0,0,0);
          }
        }
      }
    } else {
      if(set == true) {
        loadSet(imagePrefix+imageSuffix);
      } else {
      for (int i = 0; i < imageCount; i++) { 
         // Use nf() to number format 'i' into four digits 
         String filename = imagePrefix + (i+1) + imageSuffix;
         //print(filename+"\n");
         //nf(i, 4) + ".gif"; 
         images[i] = loadImage(filename); 
        
         //implement transparency, value of upper left pixel will be replaced with transparency
         if(trans) {
           color tc = images[i].pixels[0];
           for(int j = 0; j < images[0].pixels.length; j++) {
             if(tc == images[i].pixels[j]) {
               images[i].pixels[j] = color(0,0,0,1);
             }
           }
         }
       }
       }
     }
     
  } 
   
  void loadSet(String filename) {
     PImage masterImg = loadImage(filename);
     color tc = masterImg.pixels[0];
     int w = masterImg.width/imageCount;
     int h = masterImg.height;
     int index;
     
     for (int i = 0; i < imageCount; i++) { 
         
         images[i] =  createImage(w,h,RGB);
        
         //implement transparency, value of upper left pixel will be replaced with transparency
         if(trans) {
           
           for(int j = 0; j < images[i].pixels.length; j++) {
             index = (i*w)+(int(j/w)*masterImg.width)+(j%w);
             if(index >= 0 && index < masterImg.pixels.length) {
               images[i].pixels[j] = masterImg.pixels[index];
             }
             if(tc == images[i].pixels[j]) {
               images[i].pixels[j] = color(0,0,0,1);
             }
           }
         }
       }
   }
  
  void display(PVector pos) {
    image(images[frame],pos.x,pos.y);
  }
  
  void display(float x, float y) {
    image(images[frame],x,y);
  }
  
  void display(float xpos, float ypos, float wid, float hei) { 
     image(images[frame], xpos, ypos, wid, hei); 
   }
   
   void display(float xpos, float ypos, PGraphics g) {
     g.image(images[frame], xpos, ypos); 
   } 
  
  void animate() {
    if(fps > 0) {
      if(int(millis() - lastTime) > 1000/fps) {
         frame = (frame+1) % imageCount;
         lastTime=millis();
      }
    } else {
      frame = (frame+1) % imageCount; 
    }
  }
  
}
