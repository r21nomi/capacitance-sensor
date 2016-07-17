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
ItemType mItemType;
PGraphics mPg;
PGraphics mMask;
float mVoltageMax;  //電圧の最大値
float mTimeMax;  //電圧が最大値だったときの時間
SoundPlayer mSoundPlayer;

ControlP5 cp5;
Slider maskRadiusSlider;
boolean mIsDebugMode;
boolean mAddable;

void setup() {
    size(displayWidth, displayHeight);
    frameRate(60);
    background(0);
    noLoop();

    SerialPortSetup();
    mDrawController = new DrawController();
    mPg = createGraphics(width, height);
    mMask = createGraphics(width, height);

    cp5 = new ControlP5(this);
    maskRadiusSlider = cp5.addSlider(MASK_RADIUS_SLIDER_NAME);
    maskRadiusSlider.setPosition(20, 20).setSize(100, 20);
    maskRadiusSlider.show();
    maskRadiusSlider.setValue(80);
    mIsConfigEnabled = true;
    mIsDebugMode = true;
    mAddable = true;

    mSoundPlayer = new SoundPlayer();
    mItemType = ItemType.PARTICLE;
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
        if (mAddable && mVoltageMax > BOUNDARY) {
            //mDrawController.addParticle(createItem());
            mAddable = false;
            mDrawController.addParticle(createItem());
            
            new Thread(new Runnable(){
                public void run() {
                    delay(mItemType.delay);
                    mAddable = true;
                }
            }).start();
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

Item createItem() {
    switch(mItemType) {
        case CIRCLE:
            return new Circle(color(random(255), random(255), random(255)), getMaskedRadis());

        case PARTICLE:
        default:
            return new Particle(mVoltageMax, mTimeMax, VOL_MIN, VOL_MAX, BOUNDARY);
    }
}

void drawWithMask() {
    mPg.beginDraw();
    mPg.smooth();
    mPg.background(0);

    mDrawController.draw(mPg);

    mPg.endDraw();

    mMask.beginDraw();
    mMask.smooth();
    mMask.background(0);
    mMask.noStroke();
    mMask.fill(255);
    mMask.ellipse(width / 2, height / 2, getMaskedRadis(), getMaskedRadis());
    mMask.endDraw();

    mPg.mask(mMask);
    image(mPg, 0, 0);
}

float getMaskedRadis() {
    return map(maskRadiusSlider.getValue(), 0, 100, 1, height);
}

void keyReleased() {
    switch (key) {
        case ' ':
            mIsConfigEnabled = !mIsConfigEnabled;
            mIsDebugMode = !mIsDebugMode;

            if (mIsConfigEnabled) {
                maskRadiusSlider.show();
            } else {
                maskRadiusSlider.hide();
            }
            break;

        case '1':
            mItemType = ItemType.PARTICLE;
            break;

        case '2':
            mItemType = ItemType.CIRCLE;
            break;

        case '3':
            break;

        case '4':
            break;
    }
}