/**
 * Play sound on background thread.
 */
class SoundPlayer {

    SCClient scClient;
    float voltageMax;
    boolean isPlayable = true;

    public SoundPlayer(){
        scClient = new SCClient();
        isPlayable = true;
    }

    public void setVoltage(float voltage) {
        voltageMax = voltage;
    }

    public void play() {
        new Thread(new Runnable(){
            public void run() {
              playSound();
            }
        }).start();
    }

    private void playSound() {
        if (!isPlayable) {
            return;
        }
        isPlayable = false;
        scClient.play(voltageMax);

        // to avoid that the sound is played continuously.
        delay(100);
        isPlayable = true;
    }
}
