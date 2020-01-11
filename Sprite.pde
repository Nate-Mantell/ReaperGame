class Sprite {
  Animation image;
  
  PVector pos;
  
  float w,h,scw,sch;
  
  boolean visible,tint;
  int tintr,tintg,tintb;
  
  Sprite(Animation iimage, PVector ipos, float iw, float ih) {
    pos = new PVector(ipos.x,ipos.y);
    w=iw;h=ih;
    
    image = iimage;
    
    scw=image.images[0].width;sch=image.images[0].height;
    
    visible = true;
    tint=false;
    tintr=0;tintg=0;tintb=0;
  }
  
  Sprite(Animation iimage, PVector ipos, float iw, float ih, boolean iv) {
    pos = new PVector(ipos.x,ipos.y);
    w=iw;h=ih;
    
    image = iimage;
    
    scw=image.images[0].width;sch=image.images[0].height;
    
    visible = iv;
    tint=false;
    tintr=0;tintg=0;tintb=0;
  }
  
  Sprite(Animation iimage, PVector ipos, float iw, float ih, float iscw, float isch, boolean iv) {
    pos = new PVector(ipos.x,ipos.y);
    w=iw;h=ih;
    scw=iscw;sch=isch;
    
    image = iimage;
    
    visible = iv;
    tint=false;
    tintr=0;tintg=0;tintb=0;
    
  }
  
  void display() {
    image.display(pos);
  }
  
  void display (PVector offset) {
     if(visible) {
       if(tint) {
         tint(tintr,tintg,tintb);
       }
       if(scw == image.images[0].width && sch == image.images[0].height) {
         image.display(offset.x+pos.x,offset.y+pos.y-(pos.z/2));
       } else {
         image.display(offset.x+pos.x,offset.y+pos.y-(pos.z/2),scw,sch);
       }
       noTint();
     }
  }
  
  void display (float xOff, float yOff) {
     if(visible) {
       if(tint) {
         tint(tintr,tintg,tintb);
       }
       if(scw == image.images[0].width && sch == image.images[0].height) {
         image.display(xOff+pos.x,yOff+pos.y-(pos.z/2));
       } else {
         image.display(xOff+pos.x,yOff+pos.y-(pos.z/2),scw,sch);
       }
       noTint();
     }
  }
  
  
  void tint(int r, int g, int b) {
    tint=true;
    tintr=r;tintg=g;tintb=b;
  }
  
  void noTint() {
    tint=false;
  }
  
  void animate() {
    image.animate();
  }
  
}
