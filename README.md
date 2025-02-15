# PomodoroNavi
[![Image from Gyazo](https://i.gyazo.com/e914b516747021feb865c720cb5cac2e.png)](https://gyazo.com/e914b516747021feb865c720cb5cac2e)<br>
<h3>https://pomodoro-navi.com</h3>

## サービス概要
あなたの推しがナビになって作業時間を記録したり、ポモドーロを実行したことを褒めてくれるポモドーロタイマーWebアプリです。<br><br><br>

## このサービスを製作した理由
自分自身が学習でポモドーロ・テクニックををよく使っているが、マンネリ気味でやる気が起こらないときもあり「自分の好きなキャラがナビになってくれたら、勉強のモチベーションがもっと上がるのになあ」と思い、それならばとナビキャラクターとなった推しが褒めて応援してくれるポモドーロタイマーを自身で製作しました。<br><br><br>

## ユーザー層について
- 家で勉強や作業に集中する習慣をつけたい人
- 既存のポモドーロタイマーにマンネリを感じている人
- 推しや好きなキャラクターへの愛がモチベに繋がる人

”好き”を原動力に作業効率化や習慣化に楽しみを見出したり、やる気を上げてもらいたい！！<br><br><br>

## ユーザーが抱える課題とサービスによる解決イメージ
- ポモドーロタイマーを使ってないor作業に集中できない：ポモドーロテクニックで集中する習慣がない
  - 好きなキャラクターがナビになってくれることでやる気が出てポモドーロテクニックの習慣が身につく！
- 既にポモドーロタイマーを使っている人：同じことの繰り返しでマンネリを感じている
  - 無機質なタイマーでなく好きなキャラクターに褒めてもらえることで楽しみが増える！<br><br><br>

## 機能紹介
### TOPページ
[![Image from Gyazo](https://i.gyazo.com/7770693dec7ca7425854ddcfcbc64798.png)](https://gyazo.com/7770693dec7ca7425854ddcfcbc64798)
- ポモドーロタイマーの機能
  - 作業タイマー（スタート【初期設定：25分】、一時停止、終了）
    - 作業タイマーが0:00になると休憩タイマーに遷移し、次の休憩タイマーを自動開始する（アカウント登録すると自動開始をON/OFF可能）
    - ナビキャラクターからのベタ褒めと休憩を促すメッセージ、現在のポモドーロサイクル回数・作業時間・Xへのシェアリンクがウィンドウに表示される
  - 休憩タイマー（スタート【初期設定：5分】、一時停止、終了）
    - 休憩タイマーが0:00になると作業タイマーに遷移し、次のポモドーロ作業タイマーを開始する（アカウント登録すると自動開始をON/OFF可能）
    - ナビキャラクターからの応援メッセージがウィンドウに表示される
  - 長い休憩タイマー
    - ポモドーロサイクル【初期設定：4回】おきに、長い休憩【初期設定：15分】タイマーを開始する
  - 各タイマーの終了時には、アラーム音を鳴らす（アカウント登録するとON/OFF可能）
- ナビキャラクターとのチャット機能
  - ユーザーからメッセージを送信すると、ウィンドウにナビキャラクターからの回答が表示される
  - アカウント登録後のナビキャラクターは、ユーザーの送信したメッセージとその回答を記録するためAIの回答の精度が向上<br><br>

### ナビキャラクターの登録・変更画面
[![Image from Gyazo](https://i.gyazo.com/4bca1b3e9fbaf7b876dbff479c44280c.png)](https://gyazo.com/4bca1b3e9fbaf7b876dbff479c44280c)
- アカウント登録すると、ナビキャラクターの登録と設定変更ができる
  - ナビの名前、一人称、ユーザーの呼び方、アイコン画像、特徴などを自由に設定可能
  - ユーザーの設定に応じて、ナビキャラクターの口調やセリフが変化する。ユーザー好みのナビキャラクターを作成できる<br><br>

### プロフィール変更画面
[![Image from Gyazo](https://i.gyazo.com/d1068777e82d3d64d47ea37339f96bdc.png)](https://gyazo.com/d1068777e82d3d64d47ea37339f96bdc)
- ユーザーのお名前、メールアドレス、プロフィールを変更できる
  - プロフィールに今取り組んでいることや目標を設定すると、ナビがそのことに関して応援してくれるようになる<br><br>

### タイマー設定、アプリカラー設定画面
[![Image from Gyazo](https://i.gyazo.com/707fed79ae0af344a951867165ff8f65.png)](https://gyazo.com/707fed79ae0af344a951867165ff8f65)
- アプリに関する下記の設定を、ユーザー好みに自由に変更できる
  - ポモドーロタイマーの作業時間の変更
  - 休憩時間の変更
  - 長い休憩時間の変更
  - 長い休憩までのサイクル回数の変更
  - 作業（休憩）タイマーの自動開始ON/OFF
  - タイマー終了時のアラームON/OFF
  - アプリのカラー（コンテンツ表示部・ヘッダーフッター部）を変更<br><br>

### レポート画面
[![Image from Gyazo](https://i.gyazo.com/65abc1242a23de36513c5d6bb950bcb5.png)](https://gyazo.com/65abc1242a23de36513c5d6bb950bcb5)
- 特定の期間の作業時間を振り返ることができるレポート機能
  - 本日・今週・今月・今年の作業時間を棒グラフで表示する
    - グラフの上部に、各期間の累計作業時間も表示される。累計作業時間はXへシェアできる
  - グラフの下部のウィンドウに、ナビキャラクターからのちょっと役立つメッセージをランダム表示<br><br>

### カレンダー機能
[![Image from Gyazo](https://i.gyazo.com/b33b880aa39cd6ef63fb6606f3a952fa.png)](https://gyazo.com/b33b880aa39cd6ef63fb6606f3a952fa)
- これまでにポモドーロタイマーを使用した日付と作業時間を全て視覚化し、ユーザーの継続意欲を高めるカレンダー機能
  - 作業した日付の累計作業時間と、これまでの全期間の累計作業時間を「積み上げた成果」として表示する<br><br>

## その他の機能・画面
- アカウント登録・ログイン機能
- パスワードリセット機能
- Google認証機能
- X（旧Twitter）へのシェア機能
- ヘルプページ
- 利用規約・プライバシーポリシー
- Googleフォームでお問い合わせ機能
- アカウント削除機能（※実装中）　など<br><br><br>

## 使用技術
**バックエンド**
- Ruby 3.3.1
- Rails 7.1.3

**フロントエンド**
- HTML/SCSS/JavaScript
- CSSフレームワーク
  - bootstrap

**インフラ**
- Fly.io（本番環境）
- PostgreSQL（データベース）
- AmazonS3（画像アップロード先ストレージ）
- Docker（開発環境）

**主要ライブラリ**
- Device（ユーザー認証及びパスワードリセット機能）
- CarrierWave（画像アップロード機能）
- Chart.js（レポート機能のグラフ描写）
- FullCalendar.js（カレンダー機能）

**その他**
- OpenAI API（ナビキャラクターとのチャット機能）
- GoogleCloud API（Google認証機能）
- Googleアナリティクス（GA4）
- Googleサーチコンソール
- Meta-Tags（SEO対策）<br><br><br>

## 画面遷移図
https://www.figma.com/file/YW3sQ5oqfuHa4WP2nLzLT8/PomodoroNavi?node-id=2-4&t=VKcMYAsp3CnvZrFm-1<br><br><br>

## ER図
[![Image from Gyazo](https://i.gyazo.com/6e55bc8937d7e93461e0770032d46d6e.png)](https://gyazo.com/6e55bc8937d7e93461e0770032d46d6e)