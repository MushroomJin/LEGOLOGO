import controlP5.*;

ControlP5 cp5;

String input_url = "";
Textfield url_text;
Slider s_angle;

void UI(){
  int sliderWidth = 200;
  int sliderHeight = 20;
  color color_background = color(#786482);
  color color_active = color(#D2C8E6);
  color color_foreground = color(#A096B4);
  
  cp5 = new ControlP5(this,createFont("微软雅黑", 10));
  
  cp5.addBang("refresh")//刷新
    .setPosition(20, height-20-sliderHeight)
    .setSize(sliderWidth/3, sliderHeight)
    //.setColorBackground(color_background)
    .setColorActive(color_foreground)
    .setColorForeground(color_background)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addBang("output")//导出
    .setPosition(40+sliderWidth/3,height-20-sliderHeight)
    .setSize(sliderWidth/3, sliderHeight)
    //.setColorBackground(color_background)
    .setColorActive(color_foreground)
    .setColorForeground(color_background)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addSlider("color_r_1")
    .setPosition(20, 20)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(173)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addSlider("color_g_1")
    .setPosition(20,50)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(78)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addSlider("color_b_1")
    .setPosition(20,80)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(213)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addSlider("color_r_2")
    .setPosition(20,120)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(102)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addSlider("color_g_2")
    .setPosition(20,150)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(191)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addSlider("color_b_2")
    .setPosition(20,180)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,255) 
    .setValue(213)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  cp5.addDropdownList("ddl1") //选择添加孔洞类型
    .setPosition(20,220)
    .setSize(sliderWidth/2,sliderHeight*4)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    .setItemHeight(sliderHeight)
    .setBarHeight(sliderHeight)
    .setLabel("背景颜色模式")
    .addItem("固定颜色", 0)
    .addItem("纵向渐变", 1)
    .addItem("横向渐变", 2)
    .setValue(1)
    ;
    
  s_angle = cp5.addSlider("view_angle_number")
    .setPosition(width-80-sliderWidth,height-sliderHeight-20)
    .setSize(sliderWidth, sliderHeight)
    .setRange(-180,180) 
    .setValue(0)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    .setLabel("view_angle")
    ;
    
  cp5.addToggle("auto_rotate")//自动旋转
    .setPosition(width-300-sliderWidth/3,height-sliderHeight-20)
    .setSize(sliderWidth/3, sliderHeight)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    ;
    
  url_text = cp5.addTextfield("input_url")
    .setPosition(60+2*sliderWidth/3,height-sliderHeight-20)
    .setSize(sliderWidth,sliderHeight)
    .setAutoClear(false)
    .setFont(createFont("微软雅黑",10))
    .setLabel("logo_image_URL(png/jpg/tif)")
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    .setValue("https://chaowandachuang-2022-jzx.oss-cn-shanghai.aliyuncs.com/bb.png")
    ;
    
  cp5.addBang("clear_url")
    .setPosition(80+5*sliderWidth/3,height-sliderHeight-20)
    .setSize(sliderWidth/3, sliderHeight)
    //.setColorBackground(color_background)
    .setColorActive(color_foreground)
    .setColorForeground(color_background)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addBang("change_logo_url")
    .setPosition(100+2*sliderWidth,height-sliderHeight-20)
    .setSize(2*sliderWidth/3, sliderHeight)
    //.setColorBackground(color_background)
    .setColorActive(color_foreground)
    .setColorForeground(color_background)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addSlider("mesh_in")//方块密度
    .setPosition(width-sliderWidth-20, 20)
    .setSize(sliderWidth, sliderHeight)
    .setRange(10,max_mesh)
    .setValue(10)
    .setLabel("mesh")
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  //cp5.addDropdownList("ddl2") //选择输入logo类型
  //  .setPosition(20,320)
  //  .setSize(sliderWidth/2,sliderHeight*4)
  //  .setColorBackground(color_background)
  //  .setColorActive(color_active)
  //  .setColorForeground(color_foreground)
  //  .setItemHeight(sliderHeight)
  //  .setBarHeight(sliderHeight)
  //  .setLabel("输入logo文件格式")
  //  .addItem("png", 0)
  //  .addItem("jpg", 1)
  //  .addItem("tif", 2)
  //  .setValue(0)
  //  ;
    
  cp5.addDropdownList("ddl3") //选择输出logo类型
    .setPosition(20,320)
    .setSize(sliderWidth/2,sliderHeight*4)
    .setColorBackground(color_background)
    .setColorActive(color_active)
    .setColorForeground(color_foreground)
    .setItemHeight(sliderHeight)
    .setBarHeight(sliderHeight)
    .setLabel("输出logo文件格式")
    .addItem("png", 0)
    .addItem("jpg", 1)
    .addItem("tif", 2)
    .setValue(0)
    ;
    
  cp5.setAutoDraw(false);
}

void controlEvent(ControlEvent theEvent){
  //if(
  //   //theEvent.isFrom(cp5.getController("mesh"))  ||
  //   theEvent.isFrom(cp5.getController("mesh"))){
  //   if(refresh_step==0){refresh_step = 1;println("refresh");}
  //   else{println("refresh failed, please wait and retry");}
  // }
  if(
     //theEvent.isFrom(cp5.getController("view_angle_number"))  ||
     theEvent.isFrom(cp5.getController("view_angle_number"))){
     view_angle = map(view_angle_number,-180,180,0,TAU);
   }
}

void clear_url(){
  url_text.clear();
}

void change_logo_url(){
  image_url = url_text.getText();
  if(refresh_step==0){refresh_step = 1;println("refresh");}
  else{println("refresh failed, please wait and retry");}
}

void check_button(){
  if(auto_rotate){
    view_angle += 0.02;
    if(view_angle>TAU){
      view_angle = 0;
    }
    //else if(view_angle<0){
    //  view_angle = TAU;
    //}
    s_angle.setValue(map(view_angle,0,TAU,-180,180));
  }
}

void refresh(){
  if(refresh_step==0){refresh_step = 1;println("refresh");}
  else{println("refresh failed, please wait and retry");}
}

void output(){
  println("output");
  output_flag = true;
}
