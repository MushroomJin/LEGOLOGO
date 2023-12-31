float height_ratio = 2.5;
PImage im1;
int max_height = 25;

void logo_read(){
  if(rearrange.isEmpty()==false){rearrange.clear();}
  //读取网络图片，使用url链接
  if(image_url==""){im1 = loadImage("wyy.png");}
  else{im1 = loadImage(image_url);}
  //根据mesh数值和logo图片长宽比确定积木的最大高度，最大不超过30
  if(ceil(mesh*height_ratio*im1.height/im1.width)>ceil(max_mesh*height_ratio)){
    max_height = ceil(max_mesh*height_ratio);
  }
  else{
    max_height = ceil(mesh*height_ratio*im1.height/im1.width);
  }
  
  //分配像素
  for(int i=0;i<mesh;i++){
    int x1 = im1.width*i/mesh;
    int x2 = im1.width*(i+1)/mesh;
    for(int j=0;j<max_height;j++){
      int y1 = im1.height*j/max_height;
      int y2 = im1.height*(j+1)/max_height;
      int index = 0;
      float r_all = 0;
      float g_all = 0;
      float b_all = 0;
      for(int x=x1;x<x2;x++){
        for(int y=y1;y<y2;y++){
          int loc = x + y * im1.width;
          r_all += red(im1.pixels[loc]);
          g_all += green(im1.pixels[loc]);
          b_all += blue(im1.pixels[loc]);
          index++;}}
      r_all = r_all/index;
      g_all = g_all/index;
      b_all = b_all/index;
      rearrange.add(new mycolor(color(r_all,g_all,b_all)));
    }
  }
}

void logo_show(float x_in,float y_in,float width_in){
  if(rearrange.isEmpty()==false){
    float index = 10*12/mesh;
    index = width_in/(mesh*height_ratio);
    for(int x=0;x<mesh;x++){
      for(int y=0;y<max_height;y++){
        noStroke();
        fill(rearrange.get(y+x*max_height).mc);
        rect(x_in+x*index*height_ratio,y_in+y*index,index*height_ratio,index);
      }
    }
  }
}






class mycolor{
  color mc;
  mycolor(color a){mc = a;}
  color trans(float t){
    return color(red(mc),green(mc),blue(mc),t);
  }
}
