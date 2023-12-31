void project_shadow(){
  //映射关键像素
  for(int xx=0;xx<mesh;xx++){
    for(int zz=0;zz<max_height;zz++){
      //color mc = rearrange.get((max_height-zz-1)+(mesh-xx-1)*max_height).mc;
      //int tem_y = int(random(0,mesh));
      int tem_y = int(randomGaussian()*mesh/10 + mesh/2);
      while(tem_y<0 || tem_y>mesh-1){
        tem_y = int(randomGaussian()*mesh/10 + mesh/2);
      }
      state[xx][tem_y][zz] = 1;
      //顺带确定前方类型方块
      if(tem_y!=0){
        for(int yy=0;yy<tem_y;yy++){state[xx][yy][zz] = 3;}
      }
    }
  }
  //确定每一列的高度，顺带确定上下方方块类型，并排除多余前方类型
  for(int xx=0;xx<mesh;xx++){
    for(int yy=0;yy<mesh;yy++){
      int key_num = 0;
      int last_key = 0;
      for(int zz=0;zz<max_height;zz++){
        if(state[xx][yy][zz]==1){key_num++;last_key=zz+1;}
      }
      if(key_num!=0){
        if(last_key == 1){height_list[xx][yy] = 1;  //关键像素在第一层
                          for(int zz=1;zz<max_height;zz++){
                            if(state[xx][yy][zz]!=-1){state[xx][yy][zz]=-1;}
                          }}
        else if(last_key == max_height){height_list[xx][yy] = max_height; //在最高层
                          for(int zz=0;zz<max_height-1;zz++){
                            if(state[xx][yy][zz]!=3 && state[xx][yy][zz]!=1)
                              {state[xx][yy][zz]=2;}
                          }}
        else if(random(0,1)<0.99){height_list[xx][yy] = last_key;  //终止于关键像素
                          for(int zz=0;zz<last_key-1;zz++){
                            if(state[xx][yy][zz]!=3 && state[xx][yy][zz]!=1)
                              {state[xx][yy][zz]=2;}
                          }
                          for(int zz=last_key;zz<max_height;zz++){
                            if(state[xx][yy][zz]!=-1){state[xx][yy][zz]=-1;}
                          }}
        else{height_list[xx][yy] = int(random(last_key,max_height));  //继续延伸
                          for(int zz=0;zz<height_list[xx][yy];zz++){
                            if(state[xx][yy][zz]!=3 && state[xx][yy][zz]!=1)
                              {state[xx][yy][zz]=2;}
                          }
                          for(int zz=height_list[xx][yy];zz<max_height;zz++){
                            if(state[xx][yy][zz]!=-1){state[xx][yy][zz]=-1;}
                          }}
      }
      else{  //整列没有关键像素
        //int tem_h = int(abs(randomGaussian()*max_height/2));
        int tem_h = 1;
        while(tem_h<1 || tem_h>max_height){
          tem_h = int(abs(randomGaussian()*max_height/2));}
        height_list[xx][yy] = tem_h;
        for(int zz=0;zz<tem_h;zz++){
          if(state[xx][yy][zz]!=3){state[xx][yy][zz]=0;}}
        for(int zz=tem_h;zz<max_height;zz++){
          if(state[xx][yy][zz]!=-1){state[xx][yy][zz]=-1;}}
      }
  }}
  
  //开始根据方块类型进行new生成
  for(int xx=0;xx<mesh;xx++){
    for(int yy=0;yy<mesh;yy++){
      float start_height = random(550,1200);
      for(int zz=0;zz<height_list[xx][yy];zz++){
        switch(state[xx][yy][zz]){
          case 1:{
               color mc = rearrange.get((max_height-zz-1)+(mesh-xx-1)*max_height).mc;
               brick tem= new brick(xx,yy,zz,start_height,mc);
               bricks[xx][yy][zz] = tem;
               break;}
          case 2:{
               int lo = int(floor(random(0,im1.width))+floor(random(0,im1.height))*im1.width);
               color mc = im1.pixels[lo];
               if(random(0,1)<0.5){//彩色透明
                 mc = color(red(mc),green(mc),blue(mc),40);
               }
               brick tem= new brick(xx,yy,zz,start_height,mc);
               bricks[xx][yy][zz] = tem;
               break;}
          case 3:{
               color mc = rearrange.get((max_height-zz-1)+(mesh-xx-1)*max_height).mc;
               if(random(0,1)<0.5){//彩色透明
                 mc = color(red(mc),green(mc),blue(mc),40);
               }
               else if(random(0,1)<0.5){//全透明
                 mc = color(255,255,255,40);
               }
               brick tem= new brick(xx,yy,zz,start_height,mc);
               bricks[xx][yy][zz] = tem;
               break;}
          case 0:{
               int lo = int(floor(random(0,im1.width))+floor(random(0,im1.height))*im1.width);
               color mc = im1.pixels[lo];
               if(random(0,1)<0.5){//彩色透明
                 mc = color(red(mc),green(mc),blue(mc),40);
               }
               brick tem= new brick(xx,yy,zz,start_height,mc);
               bricks[xx][yy][zz] = tem;
               break;}
          case -1:{break;}
          default:{break;}
        }
        start_height += random(100,250);
  }}}
  
}
