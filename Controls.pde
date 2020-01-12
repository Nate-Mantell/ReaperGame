void keyPressed() {
  //ActiveControls.handleKeyPressed(keyCode);
}

void keyReleased() {
  //ActiveControls.handleKeyReleased(keyCode);
}

Controls ActiveControls;

class Controls {
  
  int x, y, w, h;
  color bgCol;
  color dPColReleased, dPColPressed;
  color acColReleased, acColPressed;
  color weColReleased, weColPressed;
  
  Scene scene;
  
  //WeaponUpgradeDialog weaponUpgradeDialog;
  //MenuDialog menuDialog;
  
  Button buttonRight;
  Button buttonLeft;
  Button buttonUp;
  Button buttonDown;
  Button buttonStop;
  Button buttonA;
  ButtonAHandler bah;
  Button buttonB;
  ButtonBHandler bbh;
  //Button buttonMenu;
  
  //ArrayList<WeaponToggle> weaponToggles;
  ToggleGroup weaponToggleGroup;
  
  
  Controls(int ScrW, int ScrH, Scene iscene) {
    x=0;
    y=ScrH-250;
    w=ScrW;
    h=250;
    
    scene = iscene;
    
    
    //Adjust the scene's viewport so that it doesn't waste time 
    //trying to draw underneath the control panel
    scene.viewW = ScrW;
    scene.viewH = ScrH-h;
    
    
    //weaponUpgradeDialog = new WeaponUpgradeDialog();
    //menuDialog = new MenuDialog();
    
    
    bgCol = color(164,164,164);
    
    dPColReleased = color(0,26,126);
    dPColPressed = color(0,18,84);
    
    acColReleased = color(126,0,0);
    acColPressed = color(64,0,0);
    
    weColReleased = color(164,164,164);
    weColPressed = color(104,104,104);
    
    //weaponToggles = new ArrayList<WeaponToggle>();
    weaponToggleGroup = new ToggleGroup();
    
    bah = new ButtonAHandler(scene);
    bbh = new ButtonBHandler(scene);
    
    buttonLeft = new Button(x+50,y+100,50,50,dPColReleased,dPColPressed,37,new ButtonLeftHandler(scene), new ButtonLeftReleasedHandler(scene));
    buttonRight = new Button(x+150,y+100,50,50,dPColReleased,dPColPressed,39,new ButtonRightHandler(scene), new ButtonRightReleasedHandler(scene));
    buttonUp = new Button(x+100,y+50,50,50,dPColReleased,dPColPressed,38,new ButtonUpHandler(scene), new DPadReleaseHandler());
    buttonDown = new Button(x+100,y+150,50,50,dPColReleased,dPColPressed,40,new ButtonDownHandler(scene), new DPadReleaseHandler());
    buttonStop = new Button(x+100,y+100,50,50,dPColReleased,dPColPressed,new ButtonStopHandler(scene), new ButtonStopHandler(scene));
    buttonA = new Button(x+w-300,y+100,50,50,acColReleased,acColPressed,32,bah, new ButtonAReleaseHandler(bah));
    buttonB = new Button(x+w-200,y+100,50,50,acColReleased,acColPressed,bbh, new ButtonBReleaseHandler(bbh));
    //buttonMenu = new Button(x+w-50,y+10,40,40,dPColReleased,dPColPressed,new ButtonMenuHandler(), new ButtonMenuReleaseHandler());
    
    
    /*
    //Add the weapon toggles
    for(int i = 0; i < 1; i++) {
      if(i == 0) {
        weaponToggles.add(new WeaponToggle(x+w-(9*42)-40+(i*42),y+180,40,40,weColReleased,weColPressed,true,weaponToggleGroup, Weapons[i], new WeaponToggleHandler(),new WeaponToggleReleaseHandler()));
      } else {
        weaponToggles.add(new WeaponToggle(x+w-(9*42)-40+(i*42),y+180,40,40,weColReleased,weColPressed,false,weaponToggleGroup, Weapons[i], new WeaponToggleHandler(),new WeaponToggleReleaseHandler()));
      }
      weaponToggleGroup.add(weaponToggles.get(i));
    }
    */
   
    ActiveControls = this;
  }
  
  void display() {
    //draw the background
    fill(bgCol);
    stroke(bgCol);
    rect(x,y,w,h);
    
    
    //draw the butttons
    buttonUp.display();
    buttonLeft.display();
    buttonRight.display();
    buttonDown.display();
    buttonStop.display();
    buttonA.display();
    buttonB.display();
    //buttonMenu.display();
    
    /*
    for(int i = 0; i < weaponToggles.size(); i++) {
        weaponToggles.get(i).display();
    }
    */
    
    /*
    //draw the hud
    textSize(32);
    fill(255-((float(player1.hp)/float(player1.mhp))*255),((float(player1.hp)/float(player1.mhp))*255),0);
    text("HP: " + player1.hp + "/" + player1.mhp,controls.x+controls.w-550,controls.y+64);
    if(player1.ap > 0) {
      fill(144,25,0);
      text("ARMOUR: " + player1.ap + "/" + player1.mxap,controls.x+controls.w-400,controls.y+64);
    }
    fill(0,0,((float(player1.mp)/float(player1.mmp))*255));
    text("MP: " + player1.mp + "/" + player1.mmp,controls.x+controls.w-550,controls.y+106);
    fill(0,0,0);
    text(player1.weapon.name,controls.x+controls.w-550,controls.y+148);
    fill(255,0,0);
    text(player1.weapon.damage,controls.x+controls.w-550,controls.y+190);
    fill(0,0,165);
    text(player1.weapon.mp,controls.x+controls.w-500,controls.y+190);
    image(itemImg[1].images[0],controls.x+controls.w-560,controls.y+204,34,34);
    fill(0,0,0);
    text(player1.currency,controls.x+controls.w-500,controls.y+234);
    
    
    //Display the Weapon Upgrade Dialog if it is active
    weaponUpgradeDialog.display();
    menuDialog.display();
    */
  }
  
  void check() {
    
    /*
    //If the Weapon Upgrade Dialog is active, dont check the buttons on the main controls
    if(weaponUpgradeDialog.visible) {
      weaponUpgradeDialog.check();
      return;
    }
    
    if(menuDialog.visible) {
      menuDialog.check();
      return;
    }
    */
    
    
    buttonUp.check(keyCode);
    buttonLeft.check(keyCode);
    buttonRight.check(keyCode);
    buttonDown.check(keyCode);
    buttonStop.check();
    buttonA.check(keyCode);
    buttonB.check();
    //buttonMenu.check();
    
    /*
    for(int i = 0; i < weaponToggles.size(); i++) {
        weaponToggles.get(i).check();
    }
    */
  }
  
  void handleKeyPressed(int kcode) {
    switch(kcode) {
      case 37: //left
        buttonLeft.press();
      case 39: //right
        buttonRight.press();
      case 38: //up
        buttonUp.press();
      case 40: //down
        buttonDown.press();
      case 32: //space
    }
  }
  
  void release() {
    buttonUp.release();
    buttonLeft.release();
    buttonRight.release();
    buttonDown.release();
    buttonStop.release();
    buttonA.release();
    buttonB.release();
    //buttonMenu.release();
  }
  
  void handleKeyReleased(int kcode) {
    switch(kcode) {
      case 37: //left
        buttonLeft.release();
      case 39: //right
        buttonRight.release();
      case 38: //up
        buttonUp.release();
      case 40: //down
        buttonDown.release();
      case 32: //space
    }
  }
  
  void loadSoundEffects() {
    //for(int i = 0; i < weaponToggles.size(); i++) {
        //weaponToggles.get(i).loadSoundEffect(soundEffects.menuEffects.get(0));
    //}
    //weaponUpgradeDialog.loadSoundEffects();
  }
  
  /*
  boolean doWeaponUpgrade(GameObject item) {
    
    if(weaponUpgradeDialog.success == false) {
      weaponUpgradeDialog.show(item);
    }
    
    //while(mousePressed);
    
    
    //while(weaponUpgradeDialog.visible) {
    //  weaponUpgradeDialog.check();
    //  weaponUpgradeDialog.display();
    //}
    if(weaponUpgradeDialog.success) {
      item.consumable = true;
      return true;
    } else {
      item.unconsumable(2000);
      return false;
    }
    
  }
  */
  
  void addWeapon(int weaponType) {
    //weaponToggles.add(new WeaponToggle(x+w-(9*42)-40+(weaponToggles.size()*42),y+180,40,40,weColReleased,weColPressed,false,weaponToggleGroup, Weapons[weaponType-1], new WeaponToggleHandler(),new WeaponToggleReleaseHandler()));
    //weaponToggles.get(weaponToggles.size()-1).loadSoundEffect(soundEffects.menuEffects.get(0));
    //weaponToggleGroup.add(weaponToggles.get(weaponToggles.size()-1));
  }
  
  
  
}




interface CallBack {
   
   void function();
}

class ButtonUpHandler implements CallBack {
    Scene scene;
    
    ButtonUpHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonPressedUp();
    }
}

class ButtonDownHandler implements CallBack {
  Scene scene;
  
  ButtonDownHandler(Scene iscene) {
      scene = iscene;
  }
  
  void function() {
    scene.buttonPressedDown();
  }
}

class ButtonRightHandler implements CallBack {
    Scene scene;
  
    ButtonRightHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonPressedRight();
    }
}

class ButtonLeftHandler implements CallBack {
    Scene scene;
  
    ButtonLeftHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonPressedLeft();
    }
}

class ButtonUpReleasedHandler implements CallBack {
    Scene scene;
    
    ButtonUpReleasedHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonReleasedUp();
    }
}

class ButtonDownReleasedHandler implements CallBack {
  Scene scene;
  
  ButtonDownReleasedHandler(Scene iscene) {
      scene = iscene;
  }
  
  void function() {
    scene.buttonReleasedDown();
  }
}

class ButtonRightReleasedHandler implements CallBack {
    Scene scene;
  
    ButtonRightReleasedHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonReleasedRight();
    }
}

class ButtonLeftReleasedHandler implements CallBack {
    Scene scene;
  
    ButtonLeftReleasedHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonReleasedLeft();
    }
}

class ButtonStopHandler implements CallBack {
    Scene scene;
  
    ButtonStopHandler(Scene iscene) {
      scene = iscene;
    }
    
    void function() {
      scene.buttonPressedStop();
    }
}

class ButtonAHandler implements CallBack {
    Scene scene;  
  
    boolean locked;
    
    ButtonAHandler(Scene iscene) {
      scene = iscene;
      locked=false;
    }
    
    void function() {
      if(!locked) {
        scene.player1.attack();
        locked=true;
      }
    }
}

class ButtonAReleaseHandler implements CallBack {
    Scene scene;
  
    ButtonAHandler ah;
  
    ButtonAReleaseHandler(ButtonAHandler iah) {
      ah = iah;
    }
    
    void function() {
       ah.locked=false;
    }
}

class ButtonBHandler implements CallBack {
    Scene scene;  
  
    boolean locked;
    
    ButtonBHandler(Scene iscene) {
      scene = iscene;
      locked=false;
    }
    
    void function() {
      if(!locked) {
        scene.player1.jump();
        locked=true;
      }
    }
}

class ButtonBReleaseHandler implements CallBack {
    Scene scene;
  
    ButtonBHandler bh;
  
    ButtonBReleaseHandler(ButtonBHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}

//int ReleaseCount = 0;
class DPadReleaseHandler implements CallBack {
    DPadReleaseHandler() {
      
    }
    
    void function() {
      //ReleaseCount++;
      //scene.stopScrolling();
    }
}
/*
class WeaponToggleHandler implements CallBack {
    Weapon myWeapon;
    WeaponToggle myButton;
  
    WeaponToggleHandler() {
    }
    
    void function() {
      player1.weapon = myWeapon;
    }
}

class WeaponToggleReleaseHandler implements CallBack {
  
    WeaponToggleReleaseHandler() {
      
    }
    
    void function() {
      
    }
}

class ButtonSHandler implements CallBack {
    
    boolean locked;
    
    ButtonSHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        locked=true;
        if(player1.currency >= Weapons[controls.weaponUpgradeDialog.selectedWeapon-1].upCost
           && player1.mp >= Weapons[controls.weaponUpgradeDialog.selectedWeapon-1].upMP) 
        {
          player1.currency -= Weapons[controls.weaponUpgradeDialog.selectedWeapon-1].upCost;
          player1.mp -= Weapons[controls.weaponUpgradeDialog.selectedWeapon-1].upMP;
          soundEffects.menuEffects.get(2).play();
          controls.addWeapon(controls.weaponUpgradeDialog.selectedWeapon);
          controls.weaponUpgradeDialog.success = true;
          controls.weaponUpgradeDialog.item.consumable=true;
          controls.weaponUpgradeDialog.close();
        
        } else {
          
          soundEffects.menuEffects.get(3).play();
        }
      }
    }
}

class ButtonSReleaseHandler implements CallBack {
    ButtonSHandler ah;
  
    ButtonSReleaseHandler(ButtonSHandler iah) {
      ah = iah;
    }
    
    void function() {
       ah.locked=false;
    }
}

class ButtonCHandler implements CallBack {
    
    boolean locked;
    
    ButtonCHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        controls.weaponUpgradeDialog.success = false;
        controls.weaponUpgradeDialog.close();
        locked=true;
      }
    }
}

class ButtonCReleaseHandler implements CallBack {
    ButtonCHandler bh;
  
    ButtonCReleaseHandler(ButtonCHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}

class ButtonMCHandler implements CallBack {
    
    boolean locked;
    
    ButtonMCHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        controls.menuDialog.success = false;
        controls.menuDialog.close();
        locked=true;
      }
    }
}

class ButtonMCReleaseHandler implements CallBack {
    ButtonMCHandler bh;
  
    ButtonMCReleaseHandler(ButtonMCHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}


class WeaponUpgradeToggleHandler implements CallBack {
    WeaponUpgradeToggle myButton;
  
    WeaponUpgradeToggleHandler() {
    }
    
    void function() {
      controls.weaponUpgradeDialog.selectedWeapon = this.myButton.weapon.type;
    }
}

class WeaponUpgradeToggleReleaseHandler implements CallBack {
  
    WeaponUpgradeToggleReleaseHandler() {
      
    }
    
    void function() {
      
    }
}

class ButtonScrollHandler implements CallBack {
    
    boolean locked;
    
    ButtonScrollHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        controls.weaponUpgradeDialog.itemPage = controls.weaponUpgradeDialog.itemPage==0?1:0;
        locked=true;
      }
    }
}

class ButtonScrollReleaseHandler implements CallBack {
    ButtonBHandler bh;
  
    ButtonScrollReleaseHandler(ButtonBHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}


class ButtonSVIncHandler implements CallBack {
    
    boolean locked;
    
    ButtonSVIncHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        soundtrack.increaseVolume(0.1);
        locked=true;
      }
    }
}

class ButtonSVIncReleaseHandler implements CallBack {
    ButtonSVIncHandler bh;
  
    ButtonSVIncReleaseHandler(ButtonSVIncHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}

class ButtonSVDecHandler implements CallBack {
    
    boolean locked;
    
    ButtonSVDecHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        soundtrack.decreaseVolume(0.1);
        locked=true;
      }
    }
}

class ButtonSVDecReleaseHandler implements CallBack {
    ButtonSVDecHandler bh;
  
    ButtonSVDecReleaseHandler(ButtonSVDecHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}



class ButtonSEVIncHandler implements CallBack {
    
    boolean locked;
    
    ButtonSEVIncHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        soundEffects.increaseVolume(0.1);
        locked=true;
      }
    }
}

class ButtonSEVIncReleaseHandler implements CallBack {
    ButtonSEVIncHandler bh;
  
    ButtonSEVIncReleaseHandler(ButtonSEVIncHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}


class ButtonSEVDecHandler implements CallBack {
    
    boolean locked;
    
    ButtonSEVDecHandler() {
      
      locked=false;
    }
    
    void function() {
      if(!locked) {
        soundEffects.decreaseVolume(0.1);
        locked=true;
      }
    }
}

class ButtonSEVDecReleaseHandler implements CallBack {
    ButtonSEVDecHandler bh;
  
    ButtonSEVDecReleaseHandler(ButtonSEVDecHandler ibh) {
      bh = ibh;
    }
    
    void function() {
       bh.locked=false;
    }
}


class ButtonMenuHandler implements CallBack {
    
    
    ButtonMenuHandler() {
      
    }
    
    void function() {
      if(controls.menuDialog.isDisplaying() == false) {
        controls.menuDialog.show();
      }
    }
}

class ButtonMenuReleaseHandler implements CallBack {
  
    ButtonMenuReleaseHandler() {

    }
    
    void function() {
    }
}

void mouseReleased() {
  controls.release();
}

*/



/*
class WeaponUpgradeDialog {
  int x, y, w, h;
  boolean visible;
  boolean success;
  
  int selectedWeapon;
  int itemPage;
  GameObject item;
  
  
  color bgCol;
  color scColReleased, scColPressed;
  color acColReleased, acColPressed;
  color caColReleased, caColPressed;
  color weColReleased, weColPressed;
  
  
  
  Button buttonScroll;
  Button buttonSelect;
  ButtonSHandler bsh;
  Button buttonCancel;
  ButtonCHandler bch;
  
  ArrayList<WeaponUpgradeToggle> weaponToggles;
  ToggleGroup weaponToggleGroup;
  
  
  
  WeaponUpgradeDialog() {
    x=ScrW/8;
    y=(ScrH/4);
    w=(ScrW/8)*6;
    h=(ScrH/8)*3;
    
    visible = false;
    success = false;
    
    selectedWeapon = 2;
    itemPage = 0;
    
    bgCol = color(164,164,164);
    
    scColReleased = color(0,26,126);
    scColPressed = color(0,18,84);
    
    acColReleased = color(0,126,0);
    acColPressed = color(126,0,0);
    
    caColReleased = color(86,86,86);
    caColPressed = color(126,0,0);
    
    weColReleased = color(164,164,164);
    weColPressed = color(104,104,104);
    
    weaponToggles = new ArrayList<WeaponUpgradeToggle>();
    weaponToggleGroup = new ToggleGroup();
    
    bsh = new ButtonSHandler();
    bch = new ButtonCHandler();
    
    buttonScroll = new Button(x+(w/2)-((9*42)/2)-40+(10*42),y+((h/8)*6),40,40,scColReleased,scColPressed,new ButtonStopHandler(), new ButtonStopHandler());
    buttonSelect = new Button(x+((w/8)*3),y+((h/18)*9),(w/4),(h/8),acColReleased,acColPressed,bsh, new ButtonSReleaseHandler(bsh));
    buttonCancel = new Button(x+((w/4)*3)-20,y+20,(w/4),(h/8),caColReleased,caColPressed,bch, new ButtonCReleaseHandler(bch));
    
    for(int i = 1; i < 9; i++) {
      if(i == selectedWeapon-1) {
        weaponToggles.add(new WeaponUpgradeToggle(x+(w/2)-((9*42)/2)-40+(i*42),y+((h/8)*6),40,40,weColReleased,weColPressed,true,weaponToggleGroup, Weapons[i], new WeaponUpgradeToggleHandler(),new WeaponUpgradeToggleReleaseHandler()));
      } else {
        weaponToggles.add(new WeaponUpgradeToggle(x+(w/2)-((9*42)/2)-40+(i*42),y+((h/8)*6),40,40,weColReleased,weColPressed,false,weaponToggleGroup, Weapons[i], new WeaponUpgradeToggleHandler(),new WeaponUpgradeToggleReleaseHandler()));
      }
      weaponToggleGroup.add(weaponToggles.get(i-1));
    }
  }
  
  void close() {
    visible = false;
  }
  
  void show(GameObject iitem) {
    visible = true;
    success = false;
    item = iitem;
  }
  
  void display() {
    if(!visible) return;
    
    //draw the background
    fill(bgCol);
    stroke(bgCol);
    rect(x,y,w,h);
    
    
    //draw the butttons
    buttonScroll.display();
    buttonSelect.display();
    textSize(28);
    fill(255,255,255);
    text("Select",buttonSelect.x+36,buttonSelect.y+buttonSelect.h-10);
    buttonCancel.display();
    fill(255,255,255);
    text("Cancel",buttonCancel.x+20,buttonCancel.y+buttonCancel.h-10);
    
    for(int i = 0; i < weaponToggles.size(); i++) {
        weaponToggles.get(i).display();
    }
    
    
    //draw the weapon info
    textSize(30);
    fill(0,0,0);
    text(Weapons[this.selectedWeapon-1].name,x+(w/4),y+(h/16)*3);
    fill(255,0,0);
    text(Weapons[this.selectedWeapon-1].damage,x+(w/4),y+36+(h/16)*3);
    fill(0,0,165);
    text(Weapons[this.selectedWeapon-1].mp,x+((w/4)+50),y+36+(h/16)*3);
    image(itemImg[1].images[0],x+(w/4)-10,y+44+(h/16)*3,34,34);
    fill(0,0,0);
    text(Weapons[this.selectedWeapon-1].upCost,x+((w/4)+50),y+72+(h/16)*3);
    image(itemImg[2].images[0],x+(w/4)+110,y+44+(h/16)*3,34,34);
    text(Weapons[this.selectedWeapon-1].upMP,x+((w/4)+170),y+72+(h/16)*3);
    
    
  }
  
  void check() {
    if(!visible) return;
    
    buttonScroll.check();
    buttonSelect.check();
    buttonCancel.check();
    
    for(int i = 0; i < weaponToggles.size(); i++) {
        weaponToggles.get(i).check();
    }
  }
  
  void release() {
    buttonScroll.release();
    buttonSelect.release();
    buttonCancel.release();
  }
  
  void loadSoundEffects() {
    for(int i = 0; i < weaponToggles.size(); i++) {
        weaponToggles.get(i).loadSoundEffect(soundEffects.menuEffects.get(0));
    }
  }
  
}


class MenuDialog {
  int x, y, w, h;
  boolean visible;
  boolean success;
  
  
  color bgCol;
  color scColReleased, scColPressed;
  color acColReleased, acColPressed;
  color caColReleased, caColPressed;
  color weColReleased, weColPressed;
  
  
  Button buttonCancel;
  ButtonMCHandler bch;
  
  
  Button buttonIncreaseSoundtrackVolume;
  ButtonSVIncHandler bsih;
  Button buttonDecreaseSoundtrackVolume;
  ButtonSVDecHandler bsdh;
  
  
  Button buttonIncreaseSoundEffectsVolume;
  ButtonSEVIncHandler bseih;
  Button buttonDecreaseSoundEffectsVolume;
  ButtonSEVDecHandler bsedh;
  
  
  MenuDialog() {
    x=ScrW/8;
    y=(ScrH/4);
    w=(ScrW/8)*6;
    h=(ScrH/8)*3;
    
    visible = false;
    success = false;
   
    
    bgCol = color(164,164,164);
    
    scColReleased = color(0,26,126);
    scColPressed = color(0,18,84);
    
    acColReleased = color(0,126,0);
    acColPressed = color(126,0,0);
    
    caColReleased = color(86,86,86);
    caColPressed = color(126,0,0);
    
    weColReleased = color(164,164,164);
    weColPressed = color(104,104,104);
    
    
    bch = new ButtonMCHandler();
    
    bsih = new ButtonSVIncHandler();
    bsdh = new ButtonSVDecHandler();
    
    bseih = new ButtonSEVIncHandler();
    bsedh = new ButtonSEVDecHandler();
    
    
    buttonCancel = new Button(x+((w/4)*3)-20,y+20,(w/4),(h/8),caColReleased,caColPressed,bch, new ButtonMCReleaseHandler(bch));
    
    
    buttonDecreaseSoundEffectsVolume = new Button(x+(w/2)-((9*42)/2)+240,y+((h/8)*4),40,40,caColReleased,caColPressed,bsedh, new ButtonSEVDecReleaseHandler(bsedh));
    buttonIncreaseSoundEffectsVolume = new Button(x+(w/2)-((9*42)/2)+240+120,y+((h/8)*4),40,40,caColReleased,caColPressed,bseih, new ButtonSEVIncReleaseHandler(bseih));
    
    buttonDecreaseSoundtrackVolume = new Button(x+(w/2)-((9*42)/2)+240,y+((h/8)*6),40,40,caColReleased,caColPressed,bsdh, new ButtonSVDecReleaseHandler(bsdh));
    buttonIncreaseSoundtrackVolume = new Button(x+(w/2)-((9*42)/2)+240+120,y+((h/8)*6),40,40,caColReleased,caColPressed,bsih, new ButtonSVIncReleaseHandler(bsih));
    
  }
  
  void close() {
    visible = false;
  }
  
  void show() {
    visible = true;
    success = false;
    
  }
  
  void display() {
    if(!visible) return;
    
    
    fill(bgCol);
    stroke(bgCol);
    rect(x,y,w,h);
    
    
    //draw the butttons
    
    textSize(28);
    
    buttonCancel.display();
    fill(255,255,255);
    text("Close",buttonCancel.x+20,buttonCancel.y+buttonCancel.h-10);
    
    fill(255,255,255);
    text("Sound Effects Volume:",buttonDecreaseSoundEffectsVolume.x-320,buttonDecreaseSoundEffectsVolume.y+buttonDecreaseSoundEffectsVolume.h-10);
    text(round(soundEffects.volume*100),buttonIncreaseSoundEffectsVolume.x-60,buttonIncreaseSoundEffectsVolume.y+buttonDecreaseSoundEffectsVolume.h-10);
    buttonDecreaseSoundEffectsVolume.display();
    buttonIncreaseSoundEffectsVolume.display();
    
    fill(255,255,255);
    text("Soundtrack Volume:",buttonDecreaseSoundtrackVolume.x-320,buttonDecreaseSoundtrackVolume.y+buttonDecreaseSoundtrackVolume.h-10);
    text(round(soundtrack.volume*100),buttonIncreaseSoundtrackVolume.x-60,buttonIncreaseSoundtrackVolume.y+buttonDecreaseSoundtrackVolume.h-10);
    buttonDecreaseSoundtrackVolume.display();
    buttonIncreaseSoundtrackVolume.display();
    
  }
  
  void check() {
    if(!visible) return;
    
    buttonCancel.check();
    
    buttonDecreaseSoundtrackVolume.check();
    buttonIncreaseSoundtrackVolume.check();
    
    buttonDecreaseSoundEffectsVolume.check();
    buttonIncreaseSoundEffectsVolume.check();
    
    
  }
  
  void release() {
    
    buttonCancel.release();
    
    buttonDecreaseSoundtrackVolume.release();
    buttonIncreaseSoundtrackVolume.release();
  }
  
  void loadSoundEffects() {
    
  }
  
  boolean isDisplaying() {
    return visible;
  }
  
}


class WeaponUpgradeToggle extends GroupToggle {
  Weapon weapon;
  
  WeaponUpgradeToggle(int ix,int iy,int iw,int ih,int ic, int ipc, boolean ipressed, ToggleGroup itg, Weapon iweapon, WeaponUpgradeToggleHandler iOnPressed, CallBack iOnReleased) {
    super(ix,iy,iw,ih,ic,ipc, ipressed, itg, iOnPressed, iOnReleased);
  
    weapon = iweapon;
    iOnPressed.myButton = this;
  }
  
  void display() {
    if(pressed) {
      fill(pc);
    } else {
      fill(c);
    }
    stroke(c);
    rect(x,y,w,h);
    image(weapon.boltAnimation.images[0],x+3,y+3,w-3,h-3);
  }
  
}
*/
/*
class WeaponToggle extends GroupToggle {
  Weapon weapon;
  //boolean active;
  
  
  WeaponToggle(int ix,int iy,int iw,int ih,int ic, int ipc, boolean ipressed, ToggleGroup itg, Weapon iweapon, WeaponToggleHandler iOnPressed, CallBack iOnReleased) {
    super(ix,iy,iw,ih,ic,ipc, ipressed, itg, iOnPressed, iOnReleased);
    weapon = iweapon;
    iOnPressed.myWeapon = weapon;
    iOnPressed.myButton = this;
  }
  
  void display() {
    if(pressed) {
      fill(pc);
    } else {
      fill(c);
    }
    stroke(c);
    rect(x,y,w,h);
    image(weapon.boltAnimation.images[0],x+3,y+3,w-3,h-3);
  }
  
  //void check() {
  //  if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed && !locked) {
  //    if(pressed) {
  //      //this.release();
  //    } else {
  //      this.press();
  //    }
  //    locked = true;
  //  } else if(!mousePressed && locked) {
  //    locked = false;
  //  } 
  //}
  
  //void press() {
  //  
  //  controls.releaseWeaponToggles();
  //  pressed=true;
  //  onPressed.function();
  //}
  
}
*/

class ToggleGroup {
  ArrayList<GroupToggle> toggles;
  
  ToggleGroup() {
    toggles = new ArrayList<GroupToggle>();
  }
  
  void add(GroupToggle t) {
    toggles.add(t);
  }
  
  void releaseToggles() {
    for(int i = 0; i < toggles.size(); i++) {
        toggles.get(i).unlock();
        toggles.get(i).release();
    }
  }
}

class GroupToggle extends Toggle {
  ToggleGroup toggleGroup;
  
  GroupToggle(int ix,int iy,int iw,int ih,int ic, int ipc, boolean ipressed, ToggleGroup itg, CallBack iOnPressed, CallBack iOnReleased) {
    super(ix,iy,iw,ih,ic,ipc, ipressed, iOnPressed, iOnReleased);
    toggleGroup = itg;
    //active = iactive;
  }
  
  void display() {
    if(pressed) {
      fill(pc);
    } else {
      fill(c);
    }
    stroke(c);
    rect(x,y,w,h);
  }
  
  void check() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed && !locked) {
      if(pressed) {
        //this.release();
      } else {
        this.press();
      }
      locked = true;
    } else if(!mousePressed && locked) {
      locked = false;
    } 
  }
  
  void press() {
    playSoundEffect();
    toggleGroup.releaseToggles();
    pressed=true;
    onPressed.function();
  }
  
}

class Toggle extends Button {
  boolean locked;
  
  Toggle(int ix,int iy,int iw,int ih,int ic, int ipc, boolean ipressed, CallBack iOnPressed, CallBack iOnReleased) {
    super(ix,iy,iw,ih,ic,ipc, iOnPressed, iOnReleased);
    
    pressed = ipressed;
    locked = false;
  }
  
  void check() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed && !locked) {
      if(pressed) {
        this.release();
      } else {
        this.press();
      }
      locked = true;
    } else if(!mousePressed && locked) {
      locked = false;
    } 
  }
  
  void unlock() {
    locked = false;
  }
  
  void lock() {
     locked = true;
  }
  
}

class Checkbox extends Button {
  boolean locked;
  
  Checkbox(int ix,int iy,int iw,int ih,int ic, int ipc, boolean ipressed, CallBack iOnPressed, CallBack iOnReleased) {
    super(ix,iy,iw,ih,ic,ipc, iOnPressed, iOnReleased);
    
    pressed = ipressed;
    locked = false;
  }
  
  void check() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed && !locked) {
      if(pressed) {
        this.release();
      } else {
        this.press();
      }
      locked = true;
    } else if(!mousePressed) {
      locked = false;
    } 
  }
  
  void unlock() {
    locked = false;
  }
  
  void lock() {
     locked = true;
  }
  
  void display() {
    stroke(c);
    fill(c);
    rect(x,y,w,h);
    
    if(pressed) {
      fill(pc);
      rect(x+(w/4),y+(h/4),w/2,h/2);
    }
   
  }
  
}

class Button {
  int x,y,w,h;
  int c,pc;
  boolean pressed;
  
  int kcode;
  //SoundFile soundEffect;
  
  CallBack onPressed;
  CallBack onReleased;
  
  Button(int ix,int iy,int iw,int ih,int ic, int ipc, CallBack iOnPressed, CallBack iOnReleased) {
    x=ix; y=iy; w=iw; h=ih; c=ic; pc=ipc;
    pressed = false;
    onPressed = iOnPressed;
    onReleased = iOnReleased;
    
    kcode = 0;
  }
  
  Button(int ix,int iy,int iw,int ih,int ic, int ipc, int ikcode, CallBack iOnPressed, CallBack iOnReleased) {
    x=ix; y=iy; w=iw; h=ih; c=ic; pc=ipc;
    pressed = false;
    onPressed = iOnPressed;
    onReleased = iOnReleased;
    
    kcode = ikcode;
  }
  
  void display() {
    if(pressed) {
      fill(pc);
    } else {
      fill(c);
    }
    stroke(c);
    rect(x,y,w,h);
  }
  
  void check() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed) {
      this.press();
    } else {
      this.release();
    }
  }
  
  void check(int code) {
    if((mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed) || (keyPressed && code == kcode)) {
      this.press();
    } else {
      this.release();
    }
  }
  
  void press() {
    playSoundEffect();
    pressed=true;
    onPressed.function();
  }
  
  void release() {
    if(pressed) {
      pressed=false;
      onReleased.function();
    }
  }
  
  void playSoundEffect() {
    //if(soundEffect != null) {
    //  soundEffect.play();
    //}
  }
  
  /*
  void loadSoundEffect(SoundFile se) {
    soundEffect = se;
  }
  */
}
