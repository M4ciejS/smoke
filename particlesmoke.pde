class Particle{
    int a,b,c,ma,mb,mc,opacity;
    float mass;
    PVector p;
    PVector v;
    PVector ac;
    Particle(){
      a=0;
      b=0;
      p=new PVector(0,0);
      v=new PVector(0,0);
      ac=new PVector(0,0);
    }
    Particle(PVector x,PVector y,PVector z,float m){
      p=x;
      v=y;
      ac=z;
      a=255;
      b=0;
      c=0;
      opacity=250;
      ma=1;
      mb=1;
      mc=1;
      mass=m;
    }
    void applyForce(PVector force){
       force.div(mass);
       ac.add(force); 
    }
    void update(){
      //ac.x+=random(-0.05,0.05);
      //ac.y+=random(-0.05,0.05);
      //ac.limit(0.09);
      v.add(ac);
      //v.limit(2);
      p.add(v);
      ac.mult(0);
    }
    void bounce(){
      if(p.x>800)v.x=v.x*(-1);
      if(p.x<0)v.x=v.x*(-1);
      if(p.y>600)v.y=v.y*(-1);
      if(p.y<0)v.y=v.y*(-1); 
    }
    void warp(){
      if(p.x>800)p.x=0;
      if(p.x<0)p.x=800;
      if(p.y>600)p.y=0;
      if(p.y<0)p.y=600;  
    }
  void drawR(){
    /*if(a>255){
      a=255;
      ma=ma*(-1);
    }
    if(a<0){
      a=0;
      ma=ma*(-1);
    }
    a=(a+ma*floor(random(10)));
    if(b>255){
      b=255;
      mb=mb*(-1);
    }
    if(b<0){
      b=0;
      mb=mb*(-1);
    }
    b=(b+mb*floor(random(5)));
    if(c>255){
      c=255;
      mc=mc*(-1);
    }
    if(c<0){
      c=0;
      mc=mc*(-1);
    }
    c=(c+mc*floor(random(5)));*/
    //if(a>0)a--;
    if(b<255)b++;
    fill(a,b,c,opacity);
    //fill(255,0,0,opacity);
    //stroke(0);
    //float size=random(25,50);
    ellipse(p.x,p.y,50,50);
  }
}
class ParticleEngine{
  boolean active;
  boolean randomColor;
  ArrayList<Particle> arr;
  int limit;
  int time;
  ParticleEngine(){
    arr=new ArrayList<Particle>();
    active=true;
    randomColor=false;
    limit=20;
    time=200;
  }
  void process(){
    if (mousePressed) {
      if (mouseButton==LEFT){
        active= !active;
      }else{
        randomColor=true;
      }
    }
    
    for(int i=0;i<arr.size()-1;i++){
      arr.get(i).applyForce(new PVector(0.0,0.05));//gravity
      arr.get(i).applyForce(new PVector(random(-0.05,0.05),0));//wind
      arr.get(i).update();
      //part.warp();
      arr.get(i).drawR();
      if(arr.get(i).opacity>0){
        arr.get(i).opacity--;
      }else{
        arr.remove(arr.get(i));
      }
      if(arr.get(i).p.y>610)arr.remove(arr.get(i));
      if(arr.get(i).p.y<-10)arr.remove(arr.get(i));
      if(arr.get(i).p.x>810)arr.remove(arr.get(i));
      if(arr.get(i).p.x<-10)arr.remove(arr.get(i));
      
    }
    if(active){
      arr.add(new Particle(new PVector(mouseX,mouseY),new PVector(random(-1,1),random(-1,1)),new PVector(0,0),10));
      if(randomColor){
        arr.get(arr.size()-1).a=(int)random(255);
        arr.get(arr.size()-1).b=(int)random(255);
        arr.get(arr.size()-1).c=(int)random(255);
        randomColor=false; 
      }
    }
  }
  void add(Particle p){
    if(arr.size()<limit){
      arr.add(p);
    }
  }
}
ParticleEngine pe;
ParticleEngine pe2;
void setup()
{
  background(255);
  size(800, 600);
  noStroke();
  pe=new ParticleEngine();
  /*for(int i=0;i<50;i++){
    pe.add(new Particle(new PVector(800/2,600),new PVector(random(-1,1),-2),new PVector(0,0),10));
  }*/
  pe2=new ParticleEngine(); 
  /*for(int i=0;i<20;i++){
    pe.add(new Particle(new PVector(100,100),new PVector(0.5,0.5),new PVector(0.01,0.01)));
  }*/
}
void draw()
{
  background(255);
  pe.process();
  pe2.process();
  fill(200);
  rect(0,0,300,38);
  textSize(32);
  fill(0);
  text("liczba partykli "+pe.arr.size(), 10, 30);
   
}

