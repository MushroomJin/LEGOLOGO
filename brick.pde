float brick_height = 20;
float brick_width  = 25;
float stud_height  = 9;
float pitch = 12.5;
int bounce_timer = 10;
//float Drop_Speed = 10;
float drop_speed = 10;
int collapse_timer = 100;
float height_shift = 10;
float baseplat_width = 5;
float baseplat_depth = 5;

int CREATED  = 0;
int BOUNCING = 1;
int STABLE   = 2;
int FALLING  = 3;
int FALLEN   = 4;

class brick{
  float x,y,z;  //三维位置计算
  color bcolor;
  int order_x,order_y,order_z;  //数列位置计算
  boolean landed;
  float timer;
  float drop;
  int bstate;
  /*  bstate=0(CREATED)--创建，drop>0
      bstate=1(BOUNCING)--降落后反弹中
      bstate=2(STABLE)--降落后稳定中
      bstate=3(FALLING)--跌落中
      bstate=4(FALLEN)--跌落出屏幕
  */
  
  //constructor
  brick(int in_x,int in_y,int in_z,float in_drop,color in_c){
    order_x = in_x;
    order_y = in_y;
    order_z = in_z;
    x = order_x-mesh/2;
    y = order_y-mesh/2;
    z = order_z;
    drop = in_drop;
    bcolor = in_c;
    landed = false;
    timer = bounce_timer-1;
    bstate = CREATED;
    brick_number++;
  }
  
  //更新掉落状态
  void update(){
    if(landed && this.timer>=0){    //弹跳中
      drop = brick_height/2*sin(this.timer*PI/bounce_timer);
      this.timer--;
      //println("bouncing");
    }
    else if(timer>=0 && drop<drop_speed){   //第一次落地，开始弹跳
      landed = true;
      drop = 0;
      bstate = BOUNCING;
      //println("first land");
    }
    else if(this.timer<-1){   //等待掉落解体
      this.timer++;
      //println("waiting");
    }
    else if(landed==false){  //初次掉落中
      drop -= drop_speed;
      //println("dropping");
    }
    //else{println("default");}
  }
  
  void show(float yaw){
    float adjwidth = brick_width*sqrt(2);
    float adjpitch = pitch*sqrt(2);
    float tem_x = width/2+x*brick_width*2*cos(yaw)-y*brick_width*2*sin(yaw);
    float tem_y = height/2+x*adjpitch*sin(yaw)+y*adjpitch*cos(yaw)
                  -(z-height_shift)*brick_height
                  +height_shift*(20-brick_height)
                  -drop;
                  
    fill(bcolor);
    stroke(0);
    float al;
    if(yaw>0 && yaw<=PI/2){
      al = 5*PI/4;}
    else if(yaw>PI/2 && yaw<=PI){
      al = 3*PI/4;}
    else if(yaw>PI && yaw<3*PI/2){
      al = PI/4;}
    else{
      al = 7*PI/4;}
      
      
    if(landed==false ||
       order_x==0 || order_x==mesh-1 ||
       order_y==0 || order_y==mesh-1 ||
       bricks[order_x+1][order_y][order_z] == null ||
       bricks[order_x-1][order_y][order_z] == null ||
       bricks[order_x][order_y+1][order_z] == null ||
       bricks[order_x][order_y-1][order_z] == null ||
       bricks[order_x+1][order_y][order_z].landed == false ||
       bricks[order_x-1][order_y][order_z].landed == false ||
       bricks[order_x][order_y+1][order_z].landed == false ||
       bricks[order_x][order_y-1][order_z].landed == false ||
       bricks[order_x+1][order_y][order_z].timer >= 0 ||
       bricks[order_x-1][order_y][order_z].timer >= 0 ||
       bricks[order_x][order_y+1][order_z].timer >= 0 ||
       bricks[order_x][order_y-1][order_z].timer >= 0 ||
       alpha(bricks[order_x+1][order_y][order_z].bcolor) < 255 ||
       alpha(bricks[order_x-1][order_y][order_z].bcolor) < 255 ||
       alpha(bricks[order_x][order_y+1][order_z].bcolor) < 255 ||
       alpha(bricks[order_x][order_y-1][order_z].bcolor) < 255
    ){
    //right face
    beginShape();
    vertex(tem_x-adjwidth*sin(yaw+al), tem_y+pitch*cos(yaw+al));
    vertex(tem_x-adjwidth*cos(yaw+al), tem_y-pitch*sin(yaw+al));
    vertex(tem_x-adjwidth*cos(yaw+al), tem_y-pitch*sin(yaw+al)-brick_height);
    vertex(tem_x-adjwidth*sin(yaw+al), tem_y+pitch*cos(yaw+al)-brick_height);
    vertex(tem_x-adjwidth*sin(yaw+al), tem_y+pitch*cos(yaw+al));
    endShape();
    
    //left face
    beginShape();
    vertex(tem_x+adjwidth*sin(yaw+al), tem_y-pitch*cos(yaw+al));
    vertex(tem_x-adjwidth*cos(yaw+al), tem_y-pitch*sin(yaw+al));
    vertex(tem_x-adjwidth*cos(yaw+al), tem_y-pitch*sin(yaw+al)-brick_height);
    vertex(tem_x+adjwidth*sin(yaw+al), tem_y-pitch*cos(yaw+al)-brick_height);
    vertex(tem_x+adjwidth*sin(yaw+al), tem_y-pitch*cos(yaw+al));
    endShape();
    }
    
    //top and stud
    if(landed == false ||
       order_z >= height_list[order_x][order_y]-1 ||
       bricks[order_x][order_y][order_z+1] == null ||
       bricks[order_x][order_y][order_z+1].landed==false ||
       bricks[order_x][order_y][order_z+1].timer>=0 ||
       alpha(bricks[order_x][order_y][order_z+1].bcolor) < 255
    ){
    beginShape();
    vertex(tem_x+adjwidth*cos(yaw+PI/4), tem_y-brick_height+pitch*sin(yaw+PI/4));
    vertex(tem_x+adjwidth*cos(yaw+3*PI/4), tem_y-brick_height+pitch*sin(yaw+3*PI/4));
    vertex(tem_x+adjwidth*cos(yaw+5*PI/4), tem_y-brick_height+pitch*sin(yaw+5*PI/4));
    vertex(tem_x+adjwidth*cos(yaw+7*PI/4), tem_y-brick_height+pitch*sin(yaw+7*PI/4));
    vertex(tem_x+adjwidth*cos(yaw+PI/4), tem_y-brick_height+pitch*sin(yaw+PI/4));
    endShape();
    ellipse(tem_x,tem_y-brick_height-stud_height,adjwidth/1.2,pitch);
    line(tem_x-adjwidth/2.4,tem_y-brick_height-stud_height,tem_x-adjwidth/2.4,tem_y-brick_height);
    line(tem_x+adjwidth/2.4,tem_y-brick_height-stud_height,tem_x+adjwidth/2.4,tem_y-brick_height);
    noFill();
    arc(tem_x,tem_y-brick_height,adjwidth/1.2,pitch,0,PI);
    }
    
  }
  
  
}
