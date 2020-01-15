//Forces are affected by the material the force is going through
//In the case of a force through the air, or sliding across ground, friction is applied
//Friction is applied in particular directions depending on the relationship
//of the material to the geometry of the physics object, 
//therefore we must use vectors to represent friction

//Frictions must be passed in as inverse of coefficients 
//Values range from 1 to 0 with 0 being maximum friction and 1 being no friction at all

//For this game we omit the effects of mass
//Therefore the main component of a Force object is acceleration, instead of impulse measured in newtons

class Force {
  PVector acceleration;
  PVector friction;
  
  boolean flag;
  
  Force(PVector iacceleration) {
    acceleration = iacceleration;
    friction = new PVector(1,1,1);
  }
  
  Force(PVector iacceleration, PVector ifriction) {
    acceleration = iacceleration;
    friction = ifriction;
  }
  
  Force(PVector iacceleration, boolean iflag) {
    acceleration = iacceleration;
    friction = new PVector(1,1,1);
    flag = iflag;
  }
  
  Force(PVector iacceleration, PVector ifriction, boolean iflag) {
    acceleration = iacceleration;
    friction = ifriction;
    flag = iflag;
  }
  
  PVector accelerationVector() {
    return new PVector(acceleration.x*friction.x,acceleration.y*friction.y,acceleration.z*friction.z);
  }
  
  void addFriction(PVector afriction) {
    friction.x = (friction.x + afriction.x > 1) ? 0: abs(friction.x - afriction.x);
    friction.y = (friction.y + afriction.y > 1) ? 0: abs(friction.y - afriction.y);
    friction.z = (friction.z + afriction.z > 1) ? 0: abs(friction.z - afriction.z);
  }
}

class PhysicalObject {
  PVector position;
  PVector velocity;
  
  ArrayList<Force> forces;
  
  PhysicalObject(PVector iposition) {
    position = iposition;
    velocity = new PVector(0,0,0);
    forces = new ArrayList<Force>();
  }
  
  PhysicalObject(PVector iposition, PVector ivelocity) {
    position = iposition;
    velocity = ivelocity;
    forces = new ArrayList<Force>();
  }
  
  void addForce(Force f) {
    forces.add(f);
  }
  
  void resolveForces() {
    String fstr = "";
    int i = 0;
    boolean flag = false;
    PVector sumForces = new PVector();
    for(Force force: forces) {
      sumForces.add(force.accelerationVector());
      fstr+="ACC=("+force.acceleration.x+","+force.acceleration.y+
         "), FRI=("+force.friction.x+","+force.friction.y+"), ";
      i++;
      flag = force.flag ? true : flag;
    }
    
    fstr+="\nSUM F=("+sumForces.x+","+sumForces.y+
         "), PV=("+nf(velocity.x,0,4)+","+nf(velocity.y,0,4)+"), "+
         "NV =("+nf(velocity.x+sumForces.x,0,4)+","+nf(velocity.y+sumForces.y,0,4)+")";
    scene.addMessage(fstr);
    if(i > 3 || flag) {
      print(fstr+"\n");
    }
    if(forces.size() == 0) {
      print("No forces to resolve\n");
    }
    
    velocity.x += sumForces.x;
    velocity.y += sumForces.y;
    
    forces.clear();
  }
  
  void applyVelocityToPosition() {
    position.x+=velocity.x;
    position.y+=velocity.y;
  }
  
  PVector projectedVelocity() {
    PVector sumForces = new PVector();
    for(Force force: forces) {
      sumForces.add(force.accelerationVector());
    }
    sumForces.add(velocity);
    return sumForces;
  }
}
