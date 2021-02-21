class TextBox {
  String text;
  color textColor;
  color boxColor;
  float x;
  float y;
  float w;
  float h;
  
  public TextBox(String text){
   this.text = text;
   h = 24;
   textSize(h);
   w = textWidth(text);
   x = width / 2 - w / 2;
   
   textColor = color(255);
   boxColor = color (100, 100, 100, 196);
  }
  
  public void render(){
    y = textBoxYPos;
    textSize(h);
    fill(boxColor);
    rect(x - 5, y - h / 2, w + 10, h * 2, 7);
    fill(textColor);
    text(text, x, y + h);
    textBoxYPos += textBoxYIncrement;
  }
  
  public void render(float ny){
    y = ny;
    textSize(h);
    fill(boxColor);
    rect(x - 5, y - h / 2, w + 10, h * 2, 7);
    fill(textColor);
    text(text, x, y + h);
    
  }
}

float textBoxYPos = height / 4;
final float textBoxYIncrement = 60;

void resetTextBoxYPos(){
  textBoxYPos = height / 4;
}
