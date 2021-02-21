class DialogChoice {
  public TextBox text;
  
  
  DialogChoice(String text){
     this.text = new TextBox(text); 
     this.text.boxColor = color(100, 100, 200, 196);
     this.text.textColor = color(225, 200, 200);
  }
  
  public boolean update(){
    boolean res = false;
    if(mouseX > text.x && mouseX < text.x + text.w && mouseY > text.y && mouseY < text.y + text.h){
      this.text.textColor = color(255, 255, 0);
      if(mousePressed && mouseButton == LEFT){
        res = true; 
      }
    }else{
      this.text.textColor = color(225, 200, 200);
    }
    text.y = dialogChoiceYPos;
    text.render(dialogChoiceYPos);
    dialogChoiceYPos += dialogChoiseYIncrement;
    return res;
  }
}

float dialogChoiceYPos = height - height / 4;
final float dialogChoiseYIncrement = 60;

public void resetDialogChoiceYPos(){
    dialogChoiceYPos = height - height / 4;
}
