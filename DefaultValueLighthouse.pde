class DefaultValueLighthouse extends Stage {

  class LHLevel {
    ArrayList<String> code = new ArrayList<String>();
    String answer = "";
    float tx;
    float ty = 100;
    float th = 24;
    float tw;

    final int whatsTheOutputType = 0;
    final int doesItCompileType = 1;

    int type;
    boolean valid = true;
    LHLevel() {
      

      final String[] dataTypes = {"object", "boolean", "double", "float", "byte", "char", "short", "int", "long"};
      String[] wrds = generateWordArray(7);
      String pkg = "package " + wrds[0] + ";";
      String imp = "import " + wrds[1] + ".*;";
      String className = Character.toUpperCase(wrds[2].charAt(0)) + wrds[2].substring(1);
      String cls = "public class " + className + "{";
      String mth = "    public void " + wrds[3] + "(){";
      String smt = "    public static void " + wrds[4] + "(){";
      String mmt = "    public static void main(String[] args){";
      //if(random(2) < 1){
      // type = doesItCompileType;
      //}
      //if(random(2) < 1){
      // valid = true;
      //}
      code.add(pkg);
      code.add(imp);

      if (type == whatsTheOutputType) {
        int rv = (int)random(dataTypes.length);
        String v = dataTypes[rv];
        if (v.equals("object")) {
          
        }
        if (valid) {
          switch(v){
            case "object":{
              answer = "null";
              v = WORD_LIST[(int)random(WORD_LIST.length)];
              v = Character.toUpperCase(v.charAt(0)) + v.substring(1);
             break; 
            }
            case "boolean":{
              answer = "false";
              break;
            }
            case "float":
            case "double":{
              answer = "0.0";
              break;
            }
            case "byte":
            case "char":
            case "short":
            case "int":
            case "long":
            {
             answer = "0";
              break;
            }
          }
          int rnm = (int)random(3);
          code.add(cls);
          if(rnm == 0){
            code.add("    " + v + " " + wrds[6] + ";");
          }
          code.add(mth);
          code.add("        System.out.println(" + wrds[6] + ");");
          code.add("    }");
          if(rnm == 1){
            code.add("    " + v + " " + wrds[6] + ";");
          }
          code.add(mmt);
          code.add("        new " + className + "()." + wrds[3] + "()");
          code.add("    }");
          if(rnm == 2){
            code.add("    " + v + " " + wrds[6] + ";");
          }
        } else {
          
          answer = "dnc";
        }
      } else {
        if (valid) {
        } else {
        }
      }
      code.add("}");


      textFont(courier);
      textSize(th);
      for (String s : code) {
        float ww = textWidth(s);
        if (ww > tw) {
          tw = ww;
        }
      }

      tx = resolutionWidth / 2 - tw / 2;
      textFont(arial);
    }

    String generateVariable() {
      String s = WORD_LIST[(int)random(WORD_LIST.length)];

      return null;
    }

    void render() {
      fill(255);
      textSize(35);
      if (type == whatsTheOutputType) {
        centeredText("What's the output?", 50);
      } else {
        centeredText("Does it compile?", 50);
      }
      fill(0, 0, 0, 200);
      rect(tx, ty, tw, th * code.size());

      textFont(courier);
      textSize(th);
      for (int i = 0; i < code.size(); i++) {
        String s = code.get(i);
        fill(190);
        text(s, tx, ty + (i * th) + th);
      }
      textFont(arial);
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int createVarState = 3;
  final int varScopeState = 4;
  final int classVarState = 5;
  final int instanceVarState = 6;
  final int localVarState = 7;
  final int doorSearchState = 8;
  final int playGameState = 9;

  LHLevel level;

  DefaultValueLighthouse() {
    host = loadImage("dinosaur.png");
    hostX = 50;
    hostY = 50;
    exitX = resolutionWidth / 2;
    exitY = resolutionHeight / 2;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;

    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(#8E7F6D);
    currentBackground = background;

    //DEBUG//
    currentStageState = playGameState;
    level = new LHLevel();
  }

  boolean update() {
    boolean ret = true;

    if (currentStageState < playGameState) {
      background(background.clr);
      fill(200);
      rect(exitX - camera.x, exitY - camera.y, exitW, exitH);
      image(host, hostX - camera.x, hostY - camera.y, host.width, host.height);

      if (checkForExit()) {
        if (checkInteraction()) {
          returnToWorld();
          ret = false;
        }
      }
    }
    player.update();
    camera.update();

    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, hostX - camera.x, hostY - camera.y, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to Talk to the Dinosaur", hostX - camera.x, hostY - camera.y);
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Hello there!", 
          "Do you know the default value of variables and object references in Java?");
        if (renderDialogChoice("Yes")) {
          currentStageState = doorSearchState;
        }
        if (renderDialogChoice("No")) {
          currentStageState = inquireState;
        }
        break;
      }
    case inquireState:
      {
        textBoxYPos = 50;
        dialogChoiceYPos = 120;
        renderTextBox("Would you like to know more?");
        if (renderDialogChoice("creating variables")) {
          currentStageState = createVarState;
        }
        if (renderDialogChoice("variable scope")) {
          currentStageState = varScopeState;
        }
        if (renderDialogChoice("class variables")) {
          currentStageState = classVarState;
        }
        if (renderDialogChoice("instance variables")) {
          currentStageState = instanceVarState;
        }
        if (renderDialogChoice("local variables")) {
          currentStageState = localVarState;
        }
        if (renderDialogChoice("Okay. I'm good, thanks.")) {
          currentStageState = greetingState;
        }
        break;
      }
    case createVarState:
      {
        textBoxYPos = 50;
        renderTextBox("Variable Creation:", 
          "variable_type variable_name;", 
          "Example: int x;", 
          "Variable Initialization:", 
          "variable_name = value;", 
          "Example: x = 5;", 
          "Variable Creation and Initialization:", 
          "variable_type variable_name = value;", 
          "Example: int x = 5;", 
          "Multiple variables can be created and initialized on the same line.", 
          "int x, y;", 
          "Sting a, b = \"House\", c = \"Car\";");
        if (renderDialogChoice("go back")) {
          currentStageState = inquireState;
        }
        break;
      }
    case varScopeState:
      {
        renderTextBox("Any variable created within a set of curley braces {} can only be used", 
          "in that same set of curely braces, and only after it has been created", 
          "and initialized. Instance and class variables will automatically get", 
          "initialized, but local variables will not. So any variable that is created", 
          "inside a method can only be used in that same method. The same for variables", 
          "created inside an if-statement or a for-loop.");
        if (renderDialogChoice("go back")) {
          currentStageState = inquireState;
        }
        break;
      }
    case classVarState:
      {
        renderTextBox("Class variables are the variables that are created inside of a class, but outside ", 
          "of any methods and are marked as \'static\'. Class variables can", 
          "be used in any method that is also part of that class. Integral type class", 
          "variables (byte, short, int, and long) get initialized to 0 by default. Floats", 
          "and doubles get initialized to 0.0 by default. Booleans are defaulted to false.", 
          "All objects that are class variables will be initialized to null by default.");
        if (renderDialogChoice("go back")) {
          currentStageState = inquireState;
        }
        break;
      }
    case instanceVarState:
      {
        renderTextBox("Instance variables (also called member or field variables) are the", 
          "non-static variables that are created inside of a class, but outside ", 
          "of any methods. Instance variables can be used in any non-static method that", 
          "is also part of that class. Integral type instance variables (byte,", 
          "short, int, and long) get initialized to 0 by default. Floats and doubles", 
          "get initialized to 0.0 by default. Booleans are defaulted to false. All objects", 
          "that are instance variables will be initialized to null by default.");
        if (renderDialogChoice("go back")) {
          currentStageState = inquireState;
        }
        break;
      }
    case localVarState:
      {
        renderTextBox("Local variables are the ones created inside of methods. Local", 
          "variables do not get initialized by default. So any local", 
          "variables need to be explicitly initialized before use.");
        if (renderDialogChoice("go back")) {
          currentStageState = inquireState;
        }
        break;
      }
    case doorSearchState:
      {
        fill(0, 200, 255);
        float doorX = 700;
        float doorY = 100;
        float doorW = 50;
        float doorH = 90;
        rect(700, 100, 50, 90);
        if (checkIntersection(player.x, player.y, player.w, player.h, doorX, doorY, doorW, doorH)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to Begin the Game", doorX, doorY);
          if (checkInteraction()) {
            currentStageState = playGameState; 
            level = new LHLevel();
          }
        }
        break;
      }
    case playGameState:
      {
        background(0, 200, 255);
        level.render();
        if (level.type == level.whatsTheOutputType) {
          if (renderPlayerButton("false", "output: false", 100, resolutionHeight - 150)) {
            if(level.answer.equals("false")){
              level = new LHLevel();
            }
          }
          if (renderPlayerButton("0.0", "output: 0.0", 300, resolutionHeight - 150)) {
            if(level.answer.equals("0.0")){
              level = new LHLevel();
            }
          }
          if (renderPlayerButton("0", "output: 0", 500, resolutionHeight - 150)) {
            if(level.answer.equals("0")){
              level = new LHLevel();
            }
          }
          if (renderPlayerButton("null", "output: null", 600, resolutionHeight - 150)) {
            if(level.answer.equals("null")){
              level = new LHLevel();
            }
          }
          if (renderPlayerButton("(does not compile)", "output: (error)", 700, resolutionHeight - 150)) {
            if(level.answer.equals("dnc")){
              level = new LHLevel();
            }
          }
        } else {
        }

        break;
      }
    }



    image(player.image, player.x, player.y, player.w, player.h);
    return ret;
  }
}
