import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.Collections;
import java.util.Arrays;

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
  background(50);
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
 
  appWidth = displayWidth;
  appHeight = displayHeight;
  fill(25);
  //Top Display
  rect(appWidth/4, appHeight/6, appWidth/2, appHeight*2/5); // Top Big rectangle
  fill(255); // Set text color to white
  
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Music Player", appWidth/2, appHeight/4);
  
  //Top Buttons  
  int songButtonX = appWidth*7/24;
  int artistButtonX = appWidth*61/120;
  int topButtonY = appHeight/3;
  int topButtonWidth = appWidth/5;
  int topButtonHeight = appHeight/5;
  int songHeight = appHeight/10;
  int songWidth = appWidth/10;
  
  fill(0); // Set rect color to black
  rect(songButtonX, topButtonY, topButtonWidth, topButtonHeight);
  rect(artistButtonX, topButtonY, topButtonWidth, topButtonHeight); //X, Y, Width, Height
  
  // Top Display Information
  fill(255); // Set text color to white
  textAlign(CENTER, CENTER);
  textSize(32);
  text(song[currentSong].getMetaData().title(), songButtonX + songWidth, topButtonY + songHeight);
  text(song[currentSong].getMetaData().author(), artistButtonX + songWidth, topButtonY + songHeight);
  
  //Bottom taskbar
  
  int bottomX = appWidth/8;
  int bottomY = appHeight*6/10;
  int bottomWidth = appWidth*3/4;
  int bottomHeight = appHeight/5;
  
  fill(25); // Set text color to grey
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
      
      /*
      int randomIndex;
    
      // Manually shuffle each element
      
      randomIndex = int(random(8));
      String temp0 = songNames[randomIndex];
      songNames[randomIndex] = songNames[0];
      songNames[0] = temp0;
      AudioPlayer tempSong0 = song[randomIndex];
      song[randomIndex] = song[0];
      song[0] = tempSong0;
    
      randomIndex = int(random(8));
      String temp1 = songNames[randomIndex];
      songNames[randomIndex] = songNames[1];
      songNames[1] = temp1;
      AudioPlayer tempSong1 = song[randomIndex];
      song[randomIndex] = song[1];
      song[1] = tempSong1;
    
      randomIndex = int(random(8));
      String temp2 = songNames[randomIndex];
      songNames[randomIndex] = songNames[2];
      songNames[2] = temp2;
      AudioPlayer tempSong2 = song[randomIndex];
      song[randomIndex] = song[2];
      song[2] = tempSong2;
    
      randomIndex = int(random(8));
      String temp3 = songNames[randomIndex];
      songNames[randomIndex] = songNames[3];
      songNames[3] = temp3;
      AudioPlayer tempSong3 = song[randomIndex];
      song[randomIndex] = song[3];
      song[3] = tempSong3;
    
      randomIndex = int(random(8));
      String temp4 = songNames[randomIndex];
      songNames[randomIndex] = songNames[4];
      songNames[4] = temp4;
      AudioPlayer tempSong4 = song[randomIndex];
      song[randomIndex] = song[4];
      song[4] = tempSong4;
    
      randomIndex = int(random(8));
      String temp5 = songNames[randomIndex];
      songNames[randomIndex] = songNames[5];
      songNames[5] = temp5;
      AudioPlayer tempSong5 = song[randomIndex];
      song[randomIndex] = song[5];
      song[5] = tempSong5;
    
      randomIndex = int(random(8));
      String temp6 = songNames[randomIndex];
      songNames[randomIndex] = songNames[6];
      songNames[6] = temp6;
      AudioPlayer tempSong6 = song[randomIndex];
      song[randomIndex] = song[6];
      song[6] = tempSong6;
    
      randomIndex = int(random(8));
      String temp7 = songNames[randomIndex];
      songNames[randomIndex] = songNames[7];
      songNames[7] = temp7;
      AudioPlayer tempSong7 = song[randomIndex];
      song[randomIndex] = song[7];
      song[7] = tempSong7;
      */
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
