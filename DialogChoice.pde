float dialogChoiceYPos = height - height / 4;
final float dialogChoiseYIncrement = 60;
final color defaultDialogBoxColor = color(50, 100, 200, 196);
final color defaultDialogTextOffColor = color(255);
final color defaultDialogTextOnColor = color(255, 255, 0);

public void resetDialogChoiceYPos() {
  dialogChoiceYPos = height - height / 4;
}

boolean renderDialogChoice(String text) {
  float h = textBoxTextSize;
  textSize(h);
  float tw = textWidth(text);
  renderTextBox(dialogChoiceYPos, text);
  float x = width / 2 - tw / 2;
  color tc = defaultDialogTextOffColor;
  boolean ret = false;
  if (mouseX > x - 10 && mouseX < x + tw + 10 && mouseY > dialogChoiceYPos - 10 && mouseY < dialogChoiceYPos + h + 10) {
    tc = defaultDialogTextOnColor;
    if(mousePressed && mouseButton == LEFT){
      mousePressed = false;
      ret = true;    
    }
  }
  renderTextBox(dialogChoiceYPos, defaultDialogBoxColor, tc, text);
  dialogChoiceYPos += dialogChoiseYIncrement;
  return ret;
}
