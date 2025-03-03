import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.Collections;
import java.util.Arrays;
//
//See: https://code.compartmental.net/minim/
//
//Global Variables
Minim minim;
int numberOfSongs = 8; //Able to Autodetect based on Pathway
AudioPlayer[] song = new AudioPlayer[numberOfSongs];
int currentSong = numberOfSongs - numberOfSongs;  //beginning current song as ZERO
boolean isPlaying = false;
boolean isRepeating = false;

String[] songNames = {"Cycles", "Eureka", "Ghost_Walk", "groove", "Newsroom", "Start_Your_Engines", "The_Simplest", "Beat_Your_Competition"}; // Array with song names
String[] imageNames = {"Shuffle", "Back", "Play", "Next", "Replay", "Pause"}; //Array with picture names
PImage[] images; // Images
int numberOfImages = 7;
float x, y, width1, height1;

//
void setup() {
  fullScreen();
  background(50);
  minim = new Minim(this);
  
  // Fill song array with songs
  for (int i = 0; i < numberOfSongs; i++) {
    song[i] = minim.loadFile("Music/" + songNames[i] + ".mp3"); // Load music with correct names
  }
 
  // Fill Image array with images 
  images = new PImage[numberOfImages];
  for (int i = 0; i < imageNames.length; i++) {
    images[i] = loadImage("Images/" + imageNames[i] + ".PNG"); // Load images with correct names
  }
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
  text("Not-Spotify", appWidth/2, appHeight/4);
  //Top Buttons
  
  fill(0); // Set rect color to black
  rect(appWidth*7/24, appHeight/3, appWidth/5, appHeight/5);
  rect(appWidth*61/120, appHeight/3, appWidth/5, appHeight/5); //X, Y, Width, Height
  
  fill(255); // Set text color to white
  textAlign(CENTER, CENTER);
  textSize(32);
  text(songNames[currentSong], appWidth*7/24 + appWidth/10, appHeight/3 + appHeight/10);
  text(song[currentSong].getMetaData().author(), appWidth*61/120 + appWidth/10, appHeight/3 + appHeight/10);
  
  //Bottom taskbar
  fill(25); // Set text color to grey
  rect(appWidth/8, appHeight*6/10, appWidth*3/4, appHeight/5); //X, Y, Width, Height
  
  //Bottom Buttons
  int heightYTop = appHeight*22/35;
  int appHeightTop = appHeight/7;
  int appWidthTop = appWidth/10;
  
  image(images[0], appWidth*34/200, heightYTop, appWidthTop, appHeightTop);
  image(images[1], appWidth*57/200, heightYTop, appWidthTop, appHeightTop);
  if (isPlaying) {
    image(images[5], appWidth*87/200, heightYTop, appWidthTop*4/3, appHeightTop);
  } else {
    image(images[2], appWidth*87/200, heightYTop, appWidthTop*4/3, appHeightTop);
  }
  image(images[3], appWidth*123/200, heightYTop, appWidthTop, appHeightTop);
  image(images[4], appWidth*146/200, heightYTop, appWidthTop, appHeightTop);
 
} //End draw
//
void mousePressed() {
  
  int heightYTop = displayHeight*22/35;
  int appWidthTop = displayWidth/10;
  int appHeightTop = displayHeight/7;
  
  // Check if shuffle button is clicked
  if (mouseX > displayWidth*34/200 && mouseX < displayWidth*34/200 + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
     
    String currentSongName = songNames[currentSong]; // Store current song name
    Collections.shuffle(Arrays.asList(songNames)); // Shuffle song names
    
    // Ensure the currently playing song stays in its position
    // Loop over song array, find where the current song is, and swap its position within the array to that position
    for (int i = 0; i < numberOfSongs; i++) {
      if (songNames[i].equals(currentSongName)) {
        String temp = songNames[currentSong];
        songNames[currentSong] = songNames[i];
        songNames[i] = temp;
        break; // Exit loop once songs are swapped
      }
    }
  }
  
  // Check if back button is clicked
  if (mouseX > displayWidth*57/200 && mouseX < displayWidth*57/200 + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
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
  if (mouseX > displayWidth*87/200 && mouseX < displayWidth*87/200 + appWidthTop*4/3 &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
    if (isPlaying){
      song[currentSong].pause();
    } else {
      song[currentSong].play();
    }
    isPlaying = !isPlaying; // changes pause or play no matter which is currently True
  }
  
  // Check if next button is clicked
  if (mouseX > displayWidth*123/200 && mouseX < displayWidth*123/200 + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
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
  if (mouseX > displayWidth*146/200 && mouseX < displayWidth*146/200 + appWidthTop &&
      mouseY > heightYTop && mouseY < heightYTop + appHeightTop) {
    isRepeating = !isRepeating;
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
