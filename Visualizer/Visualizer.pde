import java.util.*;

/**
 * README
 * Edit these variables with mMinVol and mMaxVol after configuration.
 */
float VOL_MIN = 80;
float VOL_MAX = 300;
float BOUNDARY = 200;

// For configuration
boolean mIsDelay = true;
float mMaxVol = 0;
float mMinVol = 200;

DrawController mDrawController;
float mVoltageMax;  //電圧の最大値
float mTimeMax;  //電圧が最大値だったときの時間

void setup() {
  size(displayWidth, displayHeight);
  frameRate(60);
  background(0);
  noLoop();
  
  SerialPortSetup();
  mDrawController = new DrawController();
}

void draw() {
  // 起動時のセンシングされてない値をカウントを最大値／最小値にカウントしないために待機処理を入れる
  if (mIsDelay) {
    delay(5000);
    mIsDelay = false;
  }

  fill(0, 255);
  rectMode(CORNER);
  rect(0, 0, width, height);

  // 最大値を0に初期化
  mVoltageMax = mTimeMax = 0;

  if (DataRecieved3) {
    // 電圧の最大値と、そのときの時間を取得
    for (int i = 0; i < Voltage3.length; i++) {
      float v = Voltage3[i];
      if (mVoltageMax < v) {
        mVoltageMax = v;
        mTimeMax = Time3[i];

        // 電圧が閾値を超えたらサウンドを再生
        if (mVoltageMax > BOUNDARY) {
          new SoundPlayer(mVoltageMax).play();
        }
      }
    }

    // 電圧が閾値を超えたら描画リストにパーティクルを追加
    if (mVoltageMax > BOUNDARY) {
      mDrawController.addParticle(new Particle(mVoltageMax, mTimeMax, VOL_MIN, VOL_MAX, BOUNDARY));
    }
    
    mDrawController.draw();

    // For configuration
    if (mVoltageMax > mMaxVol) {
      mMaxVol = mVoltageMax;
      
    } else if (mVoltageMax < mMinVol) {
      mMinVol = mVoltageMax;
    }

    println("Voltage: " + mVoltageMax + ", minVol: " + mMinVol + ", maxVol: " + mMaxVol);
  }
}