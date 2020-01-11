class Collider {
  
   ArrayList<Collision> cCol; //reuse for efficient collision detection
   
   float cx1,cx2,cy1,cy2; //calculate a box for collision detection in the center of the scaled sprite based on the w and h settings
   float z;
   
   void setcx1(float x) {
     cx1 = x;
   }
   
   void setcx2(float x) {
     cx2 = x;
   }
   
   void setcy1(float y) {
     cy1 = y;
   }
   
   void setcy2(float y) {
     cy2 = y;
   }
   
   void setz(float iz) {
     z = iz;
   }
   
   void updatePosition(float icx1,float icy1,float icx2,float icy2, float iz) {
     setcx1(icx1);
     setcy1(icy1);
     setcx2(icx2);
     setcy2(icy2);
     setz(iz);
   }
   
   Collider(float icx1,float icy1,float icx2,float icy2, float iz) {
     cx1 = icx1;
     cx2 = icx2;
     cy1 = icy1;
     cy2 = icy2;
     z = iz;
     
     cCol = new ArrayList<Collision>();
   }
  
   ArrayList<Collision> collide(ArrayList<Collider> collider) {
     cCol.clear();
     
     float xa1,xa2,ya1,ya2,xb1,xb2,yb1,yb2;
     
     xa1 = cx1;
     xa2 = cx2;
     ya1 = cy1;
     ya2 = cy2;
     
     for(int i = 0; i < collider.size(); i++) {
       
       if(this.z != collider.get(i).z) continue;
       
       xb1 = collider.get(i).cx1;
       xb2 = collider.get(i).cx2;
       yb1 = collider.get(i).cy1;
       yb2 = collider.get(i).cy2;
       
       if (xa1 < xb2 &&
        xa2 > xb1 &&
        ya1 < yb2 &&
        ya2 > yb1) {
          cCol.add(new Collision(this,collider.get(i),CollisionType.C_UNKNOWN));
        }
       
     }
     
     return cCol;
  }
  
  ArrayList<Collision> collide(Collider collider) {
     cCol.clear();
     
     
     if(this.z != collider.z) return cCol;
     
     
     float xa1,xa2,ya1,ya2,xb1,xb2,yb1,yb2;
     
     xa1 = cx1;
     xa2 = cx2;
     ya1 = cy1;
     ya2 = cy2;
     
     xb1 = collider.cx1;
     xb2 = collider.cx2;
     yb1 = collider.cy1;
     yb2 = collider.cy2;
     
     if (xa1 < xb2 &&
      xa2 > xb1 &&
      ya1 < yb2 &&
      ya2 > yb1) {
        cCol.add(new Collision(this,collider,CollisionType.C_UNKNOWN));
      }
     
     return cCol;
  }
  
}




static enum CollisionType {
  C_UNKNOWN,
  C_LOWER_RIGHT,
  C_UPPER_RIGHT,
  C_UPPER_LEFT,
  C_LOWER_LEFT,
  C_BOTTOM,
  C_TOP,
  C_RIGHT,
  C_LEFT
}


class Collision {
  Collider a,b;
  CollisionType type;
  
  Collision(Collider ia, Collider ib, CollisionType it) {
    a = ia;
    b = ib;
    type = it;
  }
  
  void determineDirection() {
    float xa1,xa2,ya1,ya2,xb1,xb2,yb1,yb2;
     
    xa1 = a.cx1;
    xa2 = a.cx2;
    ya1 = a.cy1;
    ya2 = a.cy2;
     
    xb1 = b.cx1;
    xb2 = b.cx2;
    yb1 = b.cy1;
    yb2 = b.cy2;
    
    //type 0 = unknown
    //type 1 = a lower right corner
    //type 2 = a upper right corner
    //type 3 = a upper left corner
    //type 4 = a lower left corner
    //type 5 = a bottom within b
    //type 6 = a top within b
    //type 7 = a right within b
    //type 8 = a left within b
    
    if(xa2 > xb1 && xa1 < xb2) {
      if(ya1 >= yb1 && ya2 <= yb2) {
        //type = 7;
        type = CollisionType.C_RIGHT;
      } else if(ya1 < yb1 && ya2 > yb2) {
        //type = 7;
        type = CollisionType.C_RIGHT;
      } else if(ya1 < yb1 && ya2 >= yb1) {
        //type = 1;
        type = CollisionType.C_LOWER_RIGHT;
      } else if(ya1 <= yb2 && ya2 > yb2) {
        //type = 2;
        type = CollisionType.C_UPPER_RIGHT;
      }
    } else if(xa1 < xb2 && xa1 > xb1) {
      if(ya1 >= yb1 && ya2 <= yb2) {
        //type = 8;
        type = CollisionType.C_LEFT;
      } else if(ya1 < yb1 && ya2 > yb2) {
        //type = 8;
        type = CollisionType.C_LEFT;
      } else if(ya1 < yb1 && ya2 >= yb1) {
        //type = 4;
        type = CollisionType.C_LOWER_LEFT;
      } else if(ya1 <= yb2 && ya2 > yb2) {
        //type = 3;
        type = CollisionType.C_UPPER_LEFT;
      }
    } else if(ya2 > yb1 && ya1 < yb2) {
      if(xa1 >= xb1 && xa2 <= xb2) {
        //type = 5;
        type = CollisionType.C_BOTTOM;
      } else if(xa1 < xb1 && xa2 > xb2) {
        //type = 5;
        type = CollisionType.C_BOTTOM;
      } else if(xa1 < xb1 && xa2 >= xb1) {
        //type = 1;
        type = CollisionType.C_LOWER_RIGHT;
      } else if(xa1 <= xb2 && xa2 > xb2) {
        //type = 4;
        type = CollisionType.C_LOWER_LEFT;
      }
    } else if(ya1 < yb2 && ya1 > yb1) {
      if(xa1 >= xb1 && xa2 <= xb2) {
        //type = 6;
        type = CollisionType.C_TOP;
      } else if(xa1 < xb1 && xa2 > xb2) {
        //type = 6;
        type = CollisionType.C_TOP;
      } else if(xa1 < xb1 && xa2 >= xb1) {
        //type = 2;
        type = CollisionType.C_UPPER_RIGHT;
      } else if(xa1 <= xb2 && xa2 > xb2) {
        //type = 3;
        type = CollisionType.C_UPPER_LEFT;
      }
    }  
    
  }
  
  
}
