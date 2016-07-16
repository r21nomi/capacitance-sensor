import supercollider.*;
import oscP5.*;

/**
 * Client to play a sound on supercollider.
 */
class SCClient {
    private static final String SYNTH_NAME = "ringtone";
    private Synth synth;

    SCClient() {
        synth = new Synth(SYNTH_NAME);
    }

    void play(float voltage) {
        synth.set("amp", 0.5);
        synth.set("freq", map(voltage, height, 0, 20, 8000));
        synth.create();
    }
}
