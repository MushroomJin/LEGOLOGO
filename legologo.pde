int refresh_step = 0;
boolean output_flag = false;
float color_r_1 = 173;
float color_g_1 = 78;
float color_b_1 = 213;
float color_r_2 = 102;
float color_g_2 = 191;
float color_b_2 = 213;
int ddl1 = 1;
//int ddl2 = 0;
int ddl3 = 0;
int mesh = 10;
int mesh_in = 10;
int max_mesh = 50;
int brick_number = 0;
int brick_max = 100;

brick[][][] bricks;
int[][][] state;
int[][] height_list;
/* 
state = -1:未确定&无方块
state = 0 :无关键像素相关
state = 1 :像素映射方块，必须有且固定
state = 2 :像素方块上方,下方，后方，兼容上下方+后方
state = 3 :像素方块前方，兼容上下方+前方
*/

float view_angle = PI;
float view_angle_number = 0;
boolean auto_rotate = false;

String image_url = "";
ArrayList<mycolor> rearrange;

void setup(){
  size(1600,800);
  bricks = new brick[max_mesh][max_mesh][ceil(max_mesh*height_ratio)];
  rearrange = new ArrayList<mycolor>();
  state = new int[max_mesh][max_mesh][ceil(max_mesh*height_ratio)];
  for(int i=0;i<max_mesh;i++){
    for(int j=0;j<max_mesh;j++){
      for(int k = 0;k<ceil(max_mesh*height_ratio);k++){
        state[i][j][k] = -1;
  }}}
  height_list = new int[max_mesh][max_mesh];
  for(int i=0;i<max_mesh;i++){
    for(int j=0;j<max_mesh;j++){
      height_list[i][j] = 0;
  }}
  background(0);
  UI();
  
  logo_read();
  //all_random_birth();
  //full_logo_birth();
  project_shadow();
  //bricks[0][0][0] = new brick(0,0,0,300,color(255,255,255));
  //height_list[0][0] = 1;
}



void draw(){
  //绘制背景
  draw_background();
  //绘制UI界面
  if(output_flag==false){
    noStroke();
    fill(0,100);
    rect(10,12.5,300,95);
    rect(10,112.5,300,95);
    cp5.draw();
    check_button();
    //image(im1,width-250,60,250,250*im1.height/im1.width);
    logo_show(width-250,60,250);
  }
  //角度转换
  view_angle = map(view_angle_number,-180,180,0,TAU);
  
  //brick状态更新
  switch(refresh_step){
    case 0:{break;}
    case 1:{
            for(int i=0;i<mesh;i++){
              for(int j=0;j<mesh;j++){
                float tem_timer = random(-collapse_timer,-1);
                for(int k=0;k<height_list[i][j];k++){
                  bricks[i][j][k].landed = false;
                  bricks[i][j][k].timer = tem_timer;
                  bricks[i][j][k].bstate = FALLING;
                }
              }
            }
            refresh_step = 2;
            break;}
    case 2:{
            boolean disppear_flag = true;
            for(int i=0;i<mesh;i++){
              if(disppear_flag){for(int j=0;j<mesh;j++){
                if(disppear_flag){for(int k=0;k<height_list[i][j];k++){
                  brick tem = bricks[i][j][k];
                  float tem_y = height/2+tem.x*pitch*sin(view_angle)*sqrt(2)
                  +tem.y*pitch*cos(view_angle)*sqrt(2)
                  -(tem.z-height_shift)*brick_height
                  -tem.drop;
                  if(tem_y<height+100){disppear_flag = false;break;}
                }}
              }}
            }
            if(disppear_flag){refresh_step = 3;}
            break;}
    case 3:{
            for(int i=0;i<mesh;i++){
              for(int j=0;j<mesh;j++){
                for(int k=0;k<height_list[i][j];k++){
                  bricks[i][j][k] = null;
                }
              }
            }
            for(int i=0;i<mesh;i++){
              for(int j=0;j<mesh;j++){
                height_list[i][j] = 0;
              }
            }
            for(int i=0;i<max_mesh;i++){
              for(int j=0;j<max_mesh;j++){
                for(int k = 0;k<ceil(max_mesh*height_ratio);k++){
                  state[i][j][k] = -1;
            }}}
            brick_height = brick_height*mesh/mesh_in;
            brick_width = brick_width*mesh/mesh_in;
            pitch = pitch*mesh/mesh_in;
            stud_height = stud_height*mesh/mesh_in;
            drop_speed = drop_speed*mesh_in/mesh;
            mesh = mesh_in;
            logo_read();
            project_shadow();
            //all_random_birth();
            //full_logo_birth();
            refresh_step = 0;
            break;}
    default:{break;}
  }
  
  //根据视角选择顺序进行渲染
  //logo_show();
  if(view_angle<PI/2){
    for(int i=0;i<mesh;i++){
      for(int j=0;j<mesh;j++){
        for(int k=0;k<height_list[i][j];k++){
          bricks[i][j][k].update();
          bricks[i][j][k].show(view_angle);
        }
      }
    }
  }
  else if(view_angle<PI){
    for(int i=0;i<mesh;i++){
      for(int j=mesh-1;j>=0;j--){
        for(int k=0;k<height_list[i][j];k++){
          bricks[i][j][k].update();
          bricks[i][j][k].show(view_angle);
        }
      }
    }
  }
  else if(view_angle<3*PI/2){
    for(int i=mesh-1;i>=0;i--){
      for(int j=mesh-1;j>=0;j--){
        for(int k=0;k<height_list[i][j];k++){
          bricks[i][j][k].update();
          bricks[i][j][k].show(view_angle);
        }
      }
    }
  }
  else{
    for(int i=mesh-1;i>=0;i--){
      for(int j=0;j<mesh;j++){
        for(int k=0;k<height_list[i][j];k++){
          bricks[i][j][k].update();
          bricks[i][j][k].show(view_angle);
        }
      }
    }
  }
  


  //logo输出
  if(output_flag){
    switch(ddl3){
      case 0:{saveFrame("output/####.png");break;}
      case 1:{saveFrame("output/####.jpg");break;}
      case 2:{saveFrame("output/####.tif");break;}
    }
    output_flag = false;
  }
  //saveFrame("frames/####.tif");
}


void all_random_birth(){
  for(int xx=0;xx<mesh;xx++){
    for(int yy=0;yy<mesh;yy++){
      int here_height = int(random(1,max_height));
      float start_height = random(550,1200);
      height_list[xx][yy] = here_height;
      for(int zz=0;zz<here_height;zz++){
        brick tem= new brick(xx,yy,zz,start_height,color(255));
        bricks[xx][yy][zz] = tem;
        start_height += random(150,300);
      }
    }
  }
}

void full_logo_birth(){
  for(int xx=0;xx<mesh;xx++){
    for(int yy=0;yy<1;yy++){
      int here_height = max_height;
      float start_height = random(550,1200);
      height_list[xx][yy] = here_height;
      color mc;
      for(int zz=0;zz<here_height;zz++){
        mc = rearrange.get((max_height-zz-1)+(mesh-xx-1)*max_height).mc;
        brick tem= new brick(xx,yy,zz,start_height,mc);
        bricks[xx][yy][zz] = tem;
        start_height += random(100,250);
      }
    }
  }
}

//void change_logo_birth(){
//  for(int xx=0;xx<mesh;xx++){
//    for(int yy=0;yy<mesh;yy++){
//      if(yy==0){
//      int here_height = max_height;
//      float start_height = random(550,1200);
//      height_list[xx][yy] = here_height;
//      color mc;
//      for(int zz=0;zz<here_height;zz++){
//        mc = rearrange.get((max_height-zz-1)+(mesh-xx-1)*max_height).mc;
//        brick tem= new brick(xx,yy,zz,start_height,mc);
//        bricks[xx][yy][zz] = tem;
//        start_height += random(100,250);
//      }
//    }
//    else if(xx==0){
//      height_list[xx][yy] = max_height;
//      float start_height = random(550,1200);
//      for(int zz=0;zz<max_height;zz++){
//        brick tem= new brick(xx,yy,zz,start_height,color(255));
//        bricks[xx][yy][zz] = tem;
//        start_height += random(100,250);
//      }
//    }
//   }
//  }
//}
