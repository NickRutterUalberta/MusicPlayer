// Import libraries
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Global Variables
Minim minim;
int numberOfSongs = 8;
AudioPlayer[] song = new AudioPlayer[numberOfSongs];
int currentSong = 0;
boolean isPlaying = false;
boolean isRepeating = false;

PImage image;
int numberOfImages = 7;

// Display & UI Layout
int appWidth, appHeight;
int white, darkGrey, black;

// Top Display
float topDisplayX, topDisplayY, topDisplayWidth, topDisplayHeight;

// Top Buttons
int songButtonX, artistButtonX, topButtonY, topButtonWidth, topButtonHeight;
int songHeight, songWidth;

// Bottom Taskbar
int bottomX, bottomY, bottomWidth, bottomHeight;

// Bottom Buttons
int heightYTop, appHeightTop, appWidthTop, playAppTop;
int shuffleWidth, backWidth, playWidth, nextWidth, repeatWidth;
String musicPath = "Music/";
String musicFileType = ".mp3";
// Define song file names
String songName0;
String songName1;
String songName2;
String songName3;
String songName4;
String songName5;
String songName6;
String songName7;

String imagePath = "Images/";
String imageFileType = ".jpg";

void setup() {
  fullScreen();

  // Initialize app dimensions
  appWidth = displayWidth;
  appHeight = displayHeight;

  // Define colors
  white = 255;
  darkGrey = 25;
  black = 0;

  // Initialize Minim for audio playback
  minim = new Minim(this);

  // Top Display
  topDisplayX = appWidth / 8;
  topDisplayY = appHeight / 6;
  topDisplayWidth = appWidth / 2;
  topDisplayHeight = appHeight * 2 / 5;

  // Top Buttons
  songButtonX = appWidth / 6;
  artistButtonX = appWidth * 46 / 120;
  topButtonY = appHeight / 3;
  topButtonWidth = appWidth / 5;
  topButtonHeight = appHeight / 5;
  songHeight = appHeight / 10;
  songWidth = appWidth / 10;

  // Bottom taskbar
  bottomX = appWidth / 8;
  bottomY = appHeight * 6 / 10;
  bottomWidth = appWidth * 3 / 4;
  bottomHeight = appHeight / 5;

  // Bottom Buttons
  heightYTop = appHeight * 22 / 35;
  appHeightTop = appHeight / 7;
  appWidthTop = appWidth / 10;
  playAppTop = appWidthTop * 4 / 3;

  shuffleWidth = appWidth * 34 / 200;
  backWidth = appWidth * 57 / 200;
  playWidth = appWidth * 87 / 200;
  nextWidth = appWidth * 123 / 200;
  repeatWidth = appWidth * 146 / 200;

  // Load Songs
  musicPath = "Music/";
  musicFileType = ".mp3";
  // Define song file names
  songName0 = "Cycles";
  songName1 = "Eureka";
  songName2 = "Ghost_Walk";
  songName3 = "groove";
  songName4 = "Newsroom";
  songName5 = "Start_Your_Engines";
  songName6 = "The_Simplest";
  songName7 = "Beat_Your_Competition";

    // Load each song using string concatenation
  song[0] = minim.loadFile(musicPath + songName0 + musicFileType);
  song[1] = minim.loadFile(musicPath + songName1 + musicFileType);
  song[2] = minim.loadFile(musicPath + songName2 + musicFileType);
  song[3] = minim.loadFile(musicPath + songName3 + musicFileType);
  song[4] = minim.loadFile(musicPath + songName4 + musicFileType);
  song[5] = minim.loadFile(musicPath + songName5 + musicFileType);
  song[6] = minim.loadFile(musicPath + songName6 + musicFileType);
  song[7] = minim.loadFile(musicPath + songName7 + musicFileType);

  // Load Images
  //String[] imageNames = {"Shuffle", "Back", "Play", "Next", "Replay", "Pause"};
  
  String imagePath = "Images/";
  String imageFileType = ".PNG";
  String imageName = "groove";
  
}

 
void draw() {
  
  //background(black);
  fill(darkGrey);
  rect(topDisplayX, topDisplayY, topDisplayWidth, topDisplayHeight);

  fill(white);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Music Player", appWidth * 3 / 8, appHeight / 4);

  // Top Buttons
  fill(black);
  rect(songButtonX, topButtonY, topButtonWidth, topButtonHeight);
  rect(artistButtonX, topButtonY, topButtonWidth, topButtonHeight);

  // Display song info
  fill(white);
  textAlign(CENTER, CENTER);
  textSize(32);
  text(song[currentSong].getMetaData().title(), songButtonX + songWidth, topButtonY + songHeight);
  text(song[currentSong].getMetaData().author(), artistButtonX + songWidth, topButtonY + songHeight);

  // Bottom taskbar
  fill(darkGrey);
  rect(bottomX, bottomY, bottomWidth, bottomHeight);
   
  // Bottom Buttons
  fill(white);
  rect(shuffleWidth, heightYTop, appWidthTop, appHeightTop);
  rect(backWidth, heightYTop, appWidthTop, appHeightTop);
  
  if (isPlaying) {
    rect(playWidth, heightYTop, playAppTop, appHeightTop);
  } else {
    rect(playWidth, heightYTop, playAppTop, appHeightTop);
  }

  rect(nextWidth, heightYTop, appWidthTop, appHeightTop);
  rect(repeatWidth, heightYTop, appWidthTop, appHeightTop);
  
}
 //End draw
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
