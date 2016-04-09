/**
 * Play sound on background thread.
 */
class SoundPlayer {

  SCClient scClient;
  float voltageMax;
  boolean isPlayable = true;

  public SoundPlayer(float v){
    scClient = new SCClient();
    voltageMax = v;
    isPlayable = true;
  }
  
  public void play() {
    new Thread(new Runnable(){
      public void run() {
        playSound();
      }
    }).start();
  }

  private void playSound() {
    if (isPlayable == false) {
      return;
    }
    isPlayable = false;
    scClient.play(this.voltageMax);
    
    // to avoid that the sound is played continuously.
    delay(100);
    isPlayable = true;
  }
}