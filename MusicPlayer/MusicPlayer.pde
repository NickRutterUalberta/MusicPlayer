import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Global Variables
Minim minim;
int numberOfSongs = 8;
AudioPlayer[] song = new AudioPlayer[numberOfSongs];
int currentSong = 0;
boolean isPlaying = false;
boolean isRepeating = false;

PImage[] images; // Images
int numberOfImages = 7;

float x, y, width1, height1;
  
//
void setup() {
  fullScreen();
  
  // Background Colour
  
  int mediumGrey = 50;
  background(mediumGrey);
  minim = new Minim(this);
  //beginning current song as ZERO
   // Define file paths
  String musicPath = "Music/";
  String imagePath = "Images/";

  // Define file types
  String musicFileType = ".mp3";
  String imageFileType = ".PNG";

  // Define song file names
  String songName0 = "Cycles";
  String songName1 = "Eureka";
  String songName2 = "Ghost_Walk";
  String songName3 = "groove";
  String songName4 = "Newsroom";
  String songName5 = "Start_Your_Engines";
  String songName6 = "The_Simplest";
  String songName7 = "Beat_Your_Competition";

  // Load each song using string concatenation
  song[0] = minim.loadFile(musicPath + songName0 + musicFileType);
  song[1] = minim.loadFile(musicPath + songName1 + musicFileType);
  song[2] = minim.loadFile(musicPath + songName2 + musicFileType);
  song[3] = minim.loadFile(musicPath + songName3 + musicFileType);
  song[4] = minim.loadFile(musicPath + songName4 + musicFileType);
  song[5] = minim.loadFile(musicPath + songName5 + musicFileType);
  song[6] = minim.loadFile(musicPath + songName6 + musicFileType);
  song[7] = minim.loadFile(musicPath + songName7 + musicFileType);

  // Initialize and manually load each image
  images = new PImage[numberOfImages];

  // Define image file names
  String imageName0 = "Shuffle";
  String imageName1 = "Back";
  String imageName2 = "Play";
  String imageName3 = "Next";
  String imageName4 = "Replay";
  String imageName5 = "Pause";

  // Load images using string concatenation
  images[0] = loadImage(imagePath + imageName0 + imageFileType);
  images[1] = loadImage(imagePath + imageName1 + imageFileType);
  images[2] = loadImage(imagePath + imageName2 + imageFileType);
  images[3] = loadImage(imagePath + imageName3 + imageFileType);
  images[4] = loadImage(imagePath + imageName4 + imageFileType);
  images[5] = loadImage(imagePath + imageName5 + imageFileType);
} 

void draw() {
  int appWidth;
  int appHeight;
 
  int white = 255; 
  int darkGrey = 25;
  int black = 0;
  appWidth = displayWidth;
  appHeight = displayHeight;
  
  //Top Display  
  float topDisplayX = appWidth/4;
  float topDisplayY = appHeight/6;
  float topDisplayWidth = appWidth/2;
  float topDisplayHeight = appHeight*2/5;
  fill(darkGrey);
  rect(topDisplayX, topDisplayY, topDisplayWidth, topDisplayHeight); // Top Big rectangle
  fill(white); // Set text color to white
  
  textAlign(CENTER, CENTER);
  textSize(40);
  
  float topTextWidth = appWidth/2;
  float topTextHeight = appHeight/4;
  text("Music Player", topTextWidth, topTextHeight);
  
  //Top Buttons  
  int songButtonX = appWidth*7/24;
  int artistButtonX = appWidth*61/120;
  int topButtonY = appHeight/3;
  int topButtonWidth = appWidth/5;
  int topButtonHeight = appHeight/5;
  int songHeight = appHeight/10;
  int songWidth = appWidth/10;
  
  fill(black); // Set rect color to black
  rect(songButtonX, topButtonY, topButtonWidth, topButtonHeight);
  rect(artistButtonX, topButtonY, topButtonWidth, topButtonHeight); //X, Y, Width, Height
  
  // Top Display Information
  fill(white); // Set text color to white
  textAlign(CENTER, CENTER);
  textSize(32);
  text(song[currentSong].getMetaData().title(), songButtonX + songWidth, topButtonY + songHeight);
  text(song[currentSong].getMetaData().author(), artistButtonX + songWidth, topButtonY + songHeight);
  
  //Bottom taskbar
  
  int bottomX = appWidth/8;
  int bottomY = appHeight*6/10;
  int bottomWidth = appWidth*3/4;
  int bottomHeight = appHeight/5;
  
  fill(darkGrey); // Set text color to grey
  rect(bottomX, bottomY, bottomWidth, bottomHeight); //X, Y, Width, Height
  
  //Bottom Buttons
  int heightYTop = appHeight*22/35;
  int appHeightTop = appHeight/7;
  int appWidthTop = appWidth/10;
  int playAppTop = appWidthTop*4/3;
  
  int shuffleWidth = appWidth*34/200;
  int backWidth = appWidth*57/200;
  int playWidth = appWidth*87/200;
  int nextWidth = appWidth*123/200;
  int repeatWidth = appWidth*146/200;
  
   
  image(images[0], shuffleWidth, heightYTop, appWidthTop, appHeightTop);
  image(images[1], backWidth, heightYTop, appWidthTop, appHeightTop);
  if (isPlaying) {
    fill(255);
    image(images[5], playWidth, heightYTop, playAppTop, appHeightTop);
  } else {
    image(images[2], playWidth, heightYTop, playAppTop, appHeightTop);
  }
  image(images[3], nextWidth, heightYTop, appWidthTop, appHeightTop);
  image(images[4], repeatWidth, heightYTop, appWidthTop, appHeightTop);
  
  
} //End draw
//
void mousePressed() {
  
  int heightYTop = displayHeight*22/35;
  int appWidthTop = displayWidth/10;
  int appHeightTop = displayHeight/7;
  
  // Check if shuffle button is clicked
  int shuffleWidth = displayWidth*34/200;
  
  if (mouseX >  shuffleWidth && mouseX < shuffleWidth + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
      
     
   }
   
  // Check if back button is clicked
  int backWidth = displayWidth*57/200;
  
  if (mouseX > backWidth && mouseX < backWidth + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop &&  (isRepeating == false)) {
    if (song[currentSong] != null) { // If the current song is not NULL
      song[currentSong].pause();
    }
    if (currentSong > 0) {  // Checks if it is at the begining of the song array
      currentSong--;
    } else {
      currentSong = numberOfSongs - 1; // If not; go to song at last spot of array
    }
    isPlaying = true;
    song[currentSong].play();
  }
  
  // Check if play/pause button is clicked
  int playWidth = displayWidth*87/200;
  
  if (mouseX > playWidth && mouseX < playWidth + appWidthTop*4/3 &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
    if (isPlaying){
      song[currentSong].pause();
    } else {
      song[currentSong].play();
    }
    isPlaying = !isPlaying; // changes pause or play no matter which is currently True
  }
  
  // Check if next button is clicked
  int nextWidth = displayWidth*123/200;
  
  if (mouseX > nextWidth && mouseX < nextWidth + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop &&  (isRepeating == false)) {
    if (song[currentSong] != null) {  // If the current song is not NULL
      song[currentSong].pause();
    }
    if (currentSong < numberOfSongs - 1) {
      currentSong++;
    } else {
      currentSong = 0; // Loop back to the first song if at the last song
    }
    isPlaying = true;
    song[currentSong].play();
  }
  
  // Check if repeat button is clicked
  int repeatWidth = displayWidth*146/200;
  if (mouseX > repeatWidth && mouseX < repeatWidth + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
    isRepeating = !isRepeating;
  }
  if (!isPlaying && isRepeating){
      song[currentSong].play();
  }
}
void keyPressed() {
  // Pause or play when the spacebar or 'P' key is pressed
  if (key == ' ' || key == 'p' || key == 'P') {
    if (isPlaying) {
      song[currentSong].pause();
    } else {
      song[currentSong].play();
    }
    isPlaying = !isPlaying;
  }
} 
