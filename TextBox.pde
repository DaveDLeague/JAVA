float textBoxYPos = height / 4;
final float textBoxYIncrement = 60;
final float textBoxTextSize = 24;
void resetTextBoxYPos() {
  textBoxYPos = height / 4;
}

void renderTextBox(String... text) {
  renderTextBox(textBoxYPos, text);
  textBoxYPos += textBoxYIncrement;
}

void renderTextBox(float y, String... text) {
  renderTextBox(y, color(100, 100, 100, 196), color(255), text);
}

void renderTextBox(float y, color boxColor, color textColor, String... text) {
  float h = textBoxTextSize;
  textSize(h);
  float w = 0;
  for (int i = 0; i < text.length; i++) {
    float tw = textWidth(text[i]);
    if (tw > w) w = tw;
  }
  float x = width / 2 - w / 2;
  fill(boxColor);
  float bh = (h * 1.5) + (h * text.length - 1);
  rect(x - 5, y - h / 2, w + 10, bh, 7);
  for (int i = 0; i < text.length; i++) {
    float nw = textWidth(text[i]);
    float nx = width / 2 - nw / 2;
    fill(textColor);
    text(text[i], nx, y + h + (i * h));
  }
}
