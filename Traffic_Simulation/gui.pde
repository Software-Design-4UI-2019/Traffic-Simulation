/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void speedLimitSliderChanged(GSlider source, GEvent event) { //_CODE_:speedLimitSlider:930268:
  
} //_CODE_:speedLimitSlider:930268:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:758401:
  paused = !paused;
} //_CODE_:pauseButton:758401:

public void aggressionSliderChanged(GSlider source, GEvent event) { //_CODE_:aggressionSlider:318674:

} //_CODE_:aggressionSlider:318674:

public void spawnRateSliderChanged(GSlider source, GEvent event) { //_CODE_:spawnRateSlider:743526:

} //_CODE_:spawnRateSlider:743526:

public void clearCarsButtonClicked(GButton source, GEvent event) { //_CODE_:clearCarsButton:777780:
  clearCars();
} //_CODE_:clearCarsButton:777780:

public void resetbuttonclicked(GButton source, GEvent event) { //_CODE_:resetbutton:417459:
  clearCars();
  Car C1 = new Car(new PVector(9, 0), 4, L1, new PVector(-50, 385));
  while (allCars.size()<18){
  spawnCar();}
} //_CODE_:resetbutton:417459:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  speedLimitSlider = new GSlider(this, 190, 0, 100, 40, 10.0);
  speedLimitSlider.setShowValue(true);
  speedLimitSlider.setShowLimits(true);
  speedLimitSlider.setLimits(80.0, 60.0, 120.0);
  speedLimitSlider.setNumberFormat(G4P.DECIMAL, 2);
  speedLimitSlider.setOpaque(false);
  speedLimitSlider.addEventHandler(this, "speedLimitSliderChanged");
  label1 = new GLabel(this, 100, 10, 90, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Speed Limit");
  label1.setTextBold();
  label1.setOpaque(false);
  pauseButton = new GButton(this, 10, 10, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.setTextBold();
  pauseButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  label2 = new GLabel(this, 300, 10, 90, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Aggression");
  label2.setTextBold();
  label2.setLocalColorScheme(GCScheme.RED_SCHEME);
  label2.setOpaque(false);
  aggressionSlider = new GSlider(this, 400, 0, 100, 40, 10.0);
  aggressionSlider.setShowValue(true);
  aggressionSlider.setShowLimits(true);
  aggressionSlider.setLimits(1.0, 0.0, 2.0);
  aggressionSlider.setNumberFormat(G4P.DECIMAL, 2);
  aggressionSlider.setLocalColorScheme(GCScheme.RED_SCHEME);
  aggressionSlider.setOpaque(false);
  aggressionSlider.addEventHandler(this, "aggressionSliderChanged");
  label3 = new GLabel(this, 500, 10, 90, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Spawn Rate");
  label3.setTextBold();
  label3.setOpaque(false);
  spawnRateSlider = new GSlider(this, 590, 0, 100, 40, 10.0);
  spawnRateSlider.setShowValue(true);
  spawnRateSlider.setShowLimits(true);
  spawnRateSlider.setLimits(1.0, 0.0, 5.0);
  spawnRateSlider.setNumberFormat(G4P.DECIMAL, 2);
  spawnRateSlider.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  spawnRateSlider.setOpaque(false);
  spawnRateSlider.addEventHandler(this, "spawnRateSliderChanged");
  clearCarsButton = new GButton(this, 10, 50, 80, 30);
  clearCarsButton.setText("Clear Cars");
  clearCarsButton.setTextBold();
  clearCarsButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  clearCarsButton.addEventHandler(this, "clearCarsButtonClicked");
  resetbutton = new GButton(this, 11, 91, 80, 30);
  resetbutton.setText("Reset");
  resetbutton.setTextBold();
  resetbutton.addEventHandler(this, "resetbuttonclicked");
}

// Variable declarations 
// autogenerated do not edit
GSlider speedLimitSlider; 
GLabel label1; 
GButton pauseButton; 
GLabel label2; 
GSlider aggressionSlider; 
GLabel label3; 
GSlider spawnRateSlider; 
GButton clearCarsButton; 
GButton resetbutton; 
