システムの動作には以下の手順が必要です。  
以下、`Desktop/Make2016作品_苔Mapping`フォルダで作業。

### SuperCollider
1. アプリケーションフォルダから`SuperCollider`を起動
2. `audio/sound.scd`を開く
3. 上部のメニューバーから`Language > Boot Server`
4. `Command + a`でプログラムを全選択
5. 上部のメニューバーから`Language > Evaluate Selection, Line or Region`

これでSuperCollider側の準備は完了。

### Processing
1. Macを電源に繋ぐ（必須）
2. Arduinoを接続
3. `Visualizer/Visualizer.pde`をprocessingで開く
4. `Command + shift + r`でフルスクリーンで実行

これでProcessing側の準備は完了。

あとは、線を苔に差して触れば映像投影&音が流れる。  

### プログラム実行中の操作
- 画面左上のスライダーを動かすことでグラフィックの表示可能領域が変わる
- スペースボタンを押すことで左上のスライダー&白い丸の表示が切り替わる（デバッグモードのトグル）

※Processingのプログラムを閉じて再度実行するには、一度ArduinoをPCから抜いて再接続してから実行する必要がある。  
そうでないと下記エラーが出る。
```shell
Error, disabling serialEvent() for /dev/cu.usbmodem1411
null
```
