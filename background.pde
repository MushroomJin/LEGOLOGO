int Y_AXIS = 1;
int X_AXIS = 2;


void draw_background(){
  switch(ddl1){
    case 0:{
           background(color(color_r_1,color_g_1,color_b_1));
           break;}
    case 1:{
           color c1 = color(color_r_1,color_g_1,color_b_1);
           color c2 = color(color_r_2,color_g_2,color_b_2);
           gradient(0,0,width,height,c1,c2,Y_AXIS);
           //if(outputing==false){
           //  cp5.draw();
           //}
           break;}
    case 2:{
           color c1 = color(color_r_1,color_g_1,color_b_1);
           color c2 = color(color_r_2,color_g_2,color_b_2);
           gradient(0,0,width,height,c1,c2,X_AXIS);
           //if(outputing==false){
           //  cp5.draw();
           //}
           break;}
    default:{
           background(color(color_r_1,color_g_1,color_b_1));
           break;}
  }
}


void gradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
