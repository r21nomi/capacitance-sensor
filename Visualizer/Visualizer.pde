import java.util.*;
import controlP5.*;

static final String MASK_RADIUS_SLIDER_NAME = "mast_radius";

/**
 * README
 * Edit these variables with mMinVol and mMaxVol after configuration.
 */
float VOL_MIN = 18;
float VOL_MAX = 327;
float BOUNDARY = 150;

// For configuration
boolean mIsDelay = true;
boolean mIsConfigEnabled;
float mMaxVol = 0;
float mMinVol = 200;

DrawController mDrawController;
PGraphics mPg;
PGraphics mMask;
Season mCurrentSeason;
float mVoltageMax;  //電圧の最大値
float mTimeMax;  //電圧が最大値だったときの時間
SoundPlayer mSoundPlayer;

ControlP5 cp5;
Slider maskRadiusSlider;

void setup() {
  size(displayWidth, displayHeight);
  frameRate(60);
  background(0);
  noLoop();
  
  SerialPortSetup();
  mDrawController = new DrawController();
  mPg = createGraphics(width, height);
  mMask = createGraphics(width, height);
  mCurrentSeason = Season.SPRING;
  
  cp5 = new ControlP5(this);
  maskRadiusSlider = cp5.addSlider(MASK_RADIUS_SLIDER_NAME);
  maskRadiusSlider.setPosition(20, 20).setSize(100, 20);
  maskRadiusSlider.show();
  maskRadiusSlider.setValue(80);
  mIsConfigEnabled = true;
  
  mSoundPlayer = new SoundPlayer();
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
          mSoundPlayer.setVoltage(mVoltageMax);
          mSoundPlayer.play();
        }
      }
    }

    // 電圧が閾値を超えたら描画リストにパーティクルを追加
    if (mVoltageMax > BOUNDARY) {
      mDrawController.addParticle(new Particle(mVoltageMax, mTimeMax, VOL_MIN, VOL_MAX, BOUNDARY));
    }
    
    drawWithMask();
    
    // For configuration
    if (mVoltageMax > mMaxVol) {
      mMaxVol = mVoltageMax;
      
    } else if (mVoltageMax < mMinVol) {
      mMinVol = mVoltageMax;
    }

    println("Voltage: " + mVoltageMax + ", minVol: " + mMinVol + ", maxVol: " + mMaxVol);
  }
}

void drawWithMask() {
  mPg.beginDraw();
  mPg.smooth();
  mPg.background(0);
  
  mDrawController.draw(mCurrentSeason, mPg);
  
  mPg.endDraw();
  
  mMask.beginDraw();
  mMask.smooth();
  mMask.background(0);
  mMask.noStroke();
  mMask.fill(255);
  mMask.ellipse(width / 2,
                height / 2,
                map(maskRadiusSlider.getValue(), 0, 100, 1, height),
                map(maskRadiusSlider.getValue(), 0, 100, 1, height));
  mMask.endDraw();
  
  mPg.mask(mMask);  
  image(mPg, 0, 0);
}

void keyReleased() {
  switch (key) {
    case ' ':
      mIsConfigEnabled = !mIsConfigEnabled;
      
      if (mIsConfigEnabled) {
        maskRadiusSlider.show();
      } else {
        maskRadiusSlider.hide();
      }
      break;
      
    case '1':
      mCurrentSeason = Season.SPRING;
      break;
      
    case '2':
      mCurrentSeason = Season.SUMMER;
      break;
      
    case '3':
      mCurrentSeason = Season.AUTUMN;
      break;
      
    case '4':
      mCurrentSeason = Season.WINTER;
      break;
  }
}