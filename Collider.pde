class Collider {
  
   ArrayList<Collision> cCol; //reuse for efficient collision detection
   ArrayList<LineCollision> lCol;
   
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
     lCol = new ArrayList<LineCollision>();
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
  
  /*
  ArrayList<LineCollision> collide(CollisionLine line) {
     lCol.clear();
     
     
     if(this.z != line.a.z) return lCol;
     
     
     float st,et,fst = 0,fet = 1;  
     float bmin = cx1;  
     float bmax = cx2;  
     float si = line.a.x;  
     float ei = line.b.x;  
    
     for (int i = 0; i < 3; i++) {  
        if (si < ei) {  
           if (si > bmax || ei < bmin)  
              return lCol;  
           float di = ei - si;  
           st = (si < bmin)? (bmin - si) / di: 0;  
           et = (ei > bmax)? (bmax - si) / di: 1;  
        }  
        else {  
           if (ei > bmax || si < bmin)  
              return lCol;  
           float di = ei - si;  
           st = (si > bmax)? (bmax - si) / di: 0;  
           et = (ei < bmin)? (bmin - si) / di: 1;  
        }  
    
        if (st > fst) fst = st;  
        if (et < fet) fet = et;  
        if (fet < fst)  
           return lCol;  
        bmin++; bmax++;  
        si++; ei++;  
     }  
    
    
     lCol.add(new LineCollision(this, line, fst, CollisionType.C_UNKNOWN)); 
     return lCol; 
  }
  */
  
  
  ArrayList<LineCollision> collide(CollisionLine line) {
     lCol.clear();
     
     float xa1,xa2,ya1,ya2,xb1,xb2,yb1,yb2;
     
     xa1 = cx1;
     xa2 = cx2;
     ya1 = cy1;
     ya2 = cy2;
     
     xb1 = line.a.x;
     xb2 = line.b.x;
     yb1 = line.a.y;
     yb2 = line.b.y;
     
     
     boolean left =   lineLine(xb1,yb1,xb2,yb2, xa1,ya1,xa1,ya2);
     boolean right =  lineLine(xb1,yb1,xb2,yb2, xa2,ya1,xa2,ya2);
     boolean top =    lineLine(xb1,yb1,xb2,yb2, xa1,ya1,xa2,ya1);
     boolean bottom = lineLine(xb1,yb1,xb2,yb2, xa1,ya2,xa2,ya2);
    
     if (left || right || top || bottom) {
        lCol.add(new LineCollision(this, line, CollisionType.C_UNKNOWN)); 
     }
     
     return lCol; 
  }
  
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      /*
      // optionally, draw a circle where the lines meet
      float intersectionX = x1 + (uA * (x2-x1));
      float intersectionY = y1 + (uA * (y2-y1));
      fill(255,0,0);
      noStroke();
      ellipse(intersectionX, intersectionY, 20, 20);
      */

      return true;
    }
    return false;
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
  
  CollisionType determineDirection() {
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
    
    return type;
  }
  
  String toString() {
    switch(type) {
      case C_BOTTOM:
        return "C_BOTTOM";

      case C_LOWER_RIGHT:
        return "C_LOWER_RIGHT";

      case C_LOWER_LEFT:
        return "C_LOWER_LEFT";

      case C_RIGHT:
        return "C_RIGHT";

      case C_LEFT:
        return "C_LEFT";

      case C_TOP:
        return "C_TOP";

      case C_UPPER_RIGHT:
        return "C_UPPER_RIGHT";

      case C_UPPER_LEFT:
        return "C_UPPER_LEFT";

      default:
      case C_UNKNOWN:
        return "C_UNKNOWN";

    }
  }
  
}


class LineCollision {
  Collider a;
  
  CollisionLine b;
  
  float time;
  
  CollisionType type;
  
  LineCollision(Collider ia, CollisionLine ib, CollisionType it) {
    a = ia;
    b = ib;
    type = it;
    time = 0;
  }
  
  LineCollision(Collider ia, CollisionLine ib, float itime, CollisionType it) {
    a = ia;
    b = ib;
    type = it;
    time = itime;
  }
  
  PVector getCollisionPointOnLine() {
    return b.a.sub(b.b).mult(time);
  }
  
  CollisionType determineDirection() {
    /*
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
    
    return type;
    */
    return CollisionType.C_UNKNOWN;
  }
  
  String toString() {
    switch(type) {
      case C_BOTTOM:
        return "C_BOTTOM";

      case C_LOWER_RIGHT:
        return "C_LOWER_RIGHT";

      case C_LOWER_LEFT:
        return "C_LOWER_LEFT";

      case C_RIGHT:
        return "C_RIGHT";

      case C_LEFT:
        return "C_LEFT";

      case C_TOP:
        return "C_TOP";

      case C_UPPER_RIGHT:
        return "C_UPPER_RIGHT";

      case C_UPPER_LEFT:
        return "C_UPPER_LEFT";

      default:
      case C_UNKNOWN:
        return "C_UNKNOWN";

    }
  }
  
}

enum CollisionLineDirection {
  UP,
  DOWN,
  RIGHT,
  LEFT,
  UNKNOWN
}


class CollisionLine {
  
  PVector a, b;
  CollisionLineDirection direction;
  float slopeY, slopeX;
  
  CollisionLine(PVector ia, PVector ib) {
    a=ia;
    b=ib;
    direction = CollisionLineDirection.UNKNOWN;
  }
  
  CollisionLine(PVector ia, PVector ib, CollisionLineDirection d) {
    a=ia;
    b=ib;
    direction = d;
  }
  
  void calculateSlope() {
    slopeY = getSlopeY();
    slopeX = getSlopeX();
  }
  
  PVector getNormalVector(CollisionLineDirection d) {
    switch(d) {
      default:
      case UP:
        return new PVector(-(a.x-b.x),(a.y-b.y),0).normalize();
      case DOWN:
        return new PVector((a.x-b.x),-(a.y-b.y),0).normalize();
    }
  }
  
  
  boolean isHorizontal(float threshold) {
    return (a.y-threshold <= b.y) && (a.y+threshold >= b.y);
  }
  
  boolean isVertical(float threshold) {
    return (a.x-threshold <= b.x) && (a.x+threshold >= b.x);
  }
  
  float getYatX(float x) {
    return x*slopeY;
  }
  
  float getXatY(float y) {
    return y*slopeX;
  }
  
  float getSlopeY() {
    return (b.x-a.x)/(b.y-a.y);
  }
  
  float getSlopeX() {
    return (b.y-a.y)/(b.x-a.x);
  }
  
}


class CollisionLines {
  
  ArrayList<CollisionLine> lines;
  
  CollisionLines() {
    lines = new ArrayList<CollisionLine>();
  }
  
  void load(JSONArray array) {
    if(array != null) {
      JSONObject obj;
      
      for(int i = 0; i < array.size(); i++) {
        obj = array.getJSONObject(i); 
        
        lines.add(new CollisionLine(
        new PVector(obj.getFloat("a_x"),obj.getFloat("a_y"),0), 
        new PVector(obj.getFloat("b_x"),obj.getFloat("b_y"),0),
        CollisionLineDirection.valueOf(obj.getString("direction"))
        ));
      }
    }
  }
}
