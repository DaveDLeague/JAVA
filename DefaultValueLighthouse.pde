class DefaultValueLighthouse extends Stage {

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int createVarState = 3;
  final int varScopeState = 4;
  final int classVarState = 5;
  final int instanceVarState = 6;
  final int localVarState = 7;

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
  }

  boolean update() {
    boolean ret = true;

    background(background.clr);
    player.update();
    camera.update();
    fill(200);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH);
    image(host, hostX - camera.x, hostY - camera.y, host.width, host.height);

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
        "Variable Initialization:",
        "variable_name = value;",
        "Variable Creation and Initialization:",
        "variable_type variable_name = value;");
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
        "of any methods that are marked as \'static\'. Class variables can", 
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
    }

    if (checkForExit()) {
      if (checkInteraction()) {
        returnToWorld();
        ret = false;
      }
    }       

    image(player.image, player.x, player.y, player.w, player.h);
    return ret;
  }
}
