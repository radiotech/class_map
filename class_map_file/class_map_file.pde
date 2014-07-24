PImage img;

int[][] amat = new int[9][9];

color[][] cmap = new color[9][9];

Dot[] places;

int dis = 999999999;
int[] path = new int[9];

int mapWidth = 1200;

void setup() {
  size(1200,716);
  img = loadImage("map.jpg","jpg");
  
  places = new Dot[9];
  
  places[0] = new Dot(155,329,"Edward Angel Claire Annestasia Emily","California");
  places[1] = new Dot(313,322,"Raymond Will Zuri","New York City");
  places[2] = new Dot(569,278,"Alix","Paris");
  places[3] = new Dot(302,337,"Andrew","North Carolina");
  places[4] = new Dot(268,312,"Mei-Ling","Chicago");
  places[5] = new Dot(956,352,"Fang","Nanjing");
  places[6] = new Dot(896,416,"Float","Bankok");
  places[7] = new Dot(942,372,"Penny","Zhongshan");
  places[8] = new Dot(293,376,"Jennie","Florida");
  
  
  
  for(int i = 0; i<9; i++){
    for(int j = 0; j<9; j++){
      cmap[i][j] = color(0,random(155)+100,0);
    }
    
    path[i] = i;
    
  }
  
  
  for(int i = 0; i<9; i++){
    for(int j = 0; j<9; j++){
      amat[i][j] = round( sqrt(pow(places[i].xpos-places[j].xpos,2)+pow(places[i].ypos-places[j].ypos,2)) );
    }
  }
  
}

class Dot{
  
  int xpos;
  int ypos;
  
  String name;
  String loc;
  
  Dot(int tempxpos, int tempypos, String tempname, String temploc){
    xpos = tempxpos;
    ypos = tempypos;
    
    name = tempname;
    loc = temploc;
  }
  
  boolean display(){
    ellipseMode(CENTER);
    fill(255,0,0);
    stroke(255,0,0);
    ellipse(xpos,ypos,5,5);
    
    if(sqrt(pow(mouseX-xpos,2)+pow(mouseY-ypos,2)) < 5){
      ellipse(xpos,ypos,15,15);
      
      fill(255);
      stroke(255);
      
      
      rect(xpos,ypos-40,max(loc.length()*8,name.length()*8),40,5);
      
      
      fill(0);
      //textMode(CENTER);
      text(name,xpos+5,ypos-25);
      text(loc,xpos+5,ypos-5);
    }
    
    return true;
  }
}

void draw() {
  
   
  image(img,0,0);
  
  stroke(0,0,255);
  for(int i = 0; i<9; i++){
    for(int j = 0; j<9; j++){
      stroke(cmap[i][j]);
      bestLine(places[i].xpos,places[i].ypos,places[j].xpos,places[j].ypos);
    }
    
    
  }
  
  
  for(int i = 0; i<8; i++){
    stroke(color(255,0,0));
    bestLine(places[path[i]].xpos,places[path[i]].ypos,places[path[i+1]].xpos,places[path[i+1]].ypos);
  }
  
  //bestLine(places[0].xpos,places[0].ypos,mouseX,mouseY);
  
  for(int i = 0; i<9; i++){
    places[i].display();
  }
  
  places[0].display();
  
  
  
  
  
}

boolean bestLine(int txpos1, int typos1, int txpos2, int typos2){
  
  if(disType(txpos1, typos1, txpos2, typos2)){
    if(txpos1 > txpos2){
      int tempvar = txpos1;
      txpos1 = txpos2;
      txpos2 = tempvar;
      
      tempvar = typos1;
      typos1 = typos2;
      typos2 = tempvar;
    }
      
    
    line(txpos1, typos1, txpos2-mapWidth, typos2);
    line(txpos1+mapWidth, typos1, txpos2, typos2);
    
    
  } else {
    line(txpos1, typos1, txpos2, typos2);
  }
  
  return true;
}

boolean disType(int txpos1, int typos1, int txpos2, int typos2){
  boolean myreturn = false;
  
  int dis1 = pointDistance(txpos1, typos1, txpos2, typos2);
  
  int dis2 = round(sqrt(pow(mapWidth-abs(txpos1-txpos2),2)+pow(typos1-typos2,2)));
  
  
  if(dis2 < dis1){
    myreturn = true;
  }
  
  return myreturn;
}

int bestDis(int txpos1, int typos1, int txpos2, int typos2){
  int dis1 = pointDistance(txpos1, typos1, txpos2, typos2);
  
  int dis2 = round(sqrt(pow(mapWidth-abs(txpos1-txpos2),2)+pow(typos1-typos2,2)));
  
  return min(dis1,dis2);
}

int pointDistance(int txpos1, int typos1, int txpos2, int typos2){
  return round(sqrt(pow(txpos1-txpos2,2)+pow(typos1-typos2,2)));
}


void mousePressed() {
  println(mouseX+", "+mouseY);
}
