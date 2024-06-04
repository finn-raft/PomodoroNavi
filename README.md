# PomodoroNavi
## サービス概要
自分の推しがナビになってポモドーロ回数を記録してくれたり行動を褒めてくれるポモドーロタイマー

## このサービスへの思い・作りたい理由
自分自身が学習でポモドーロタイマーをよく使っているがマンネリ気味。
「自分の好きなキャラがナビになってくれたら勉強のモチベーションがもっと上がるのになあ」と思い、それならば自分で作ってみたくなった。

## ユーザー層について
- 家で勉強や作業に集中する習慣をつけたい人
- 既存の無機質なポモドーロタイマーにマンネリを感じている人
- 推しや好きなキャラクターへの愛がモチベに繋がる人

”好き”を原動力に作業効率化や習慣化に楽しみを見出したり、やる気を上げてもらいたい！！

## ユーザーが抱える課題とサービスによる解決イメージ
- ポモドーロタイマーを使ってないor作業に集中できない：ポモドーロテクニックで集中する習慣がない
  - 好きなキャラクターがナビになってくれることでやる気が出てポモドーロテクニックの習慣が身につく！
- 既にポモドーロタイマーを使っている人：同じことの繰り返しでマンネリを感じている
  - 無機質なタイマーでなく好きなキャラクターに褒めてもらえることで楽しみが増える！

## ユーザーの獲得について
- Xを使ってシェア
- Qiitaで宣伝記事を書いて投稿

## サービスの差別化ポイント・推しポイント
既存のポモドーロタイマーは、シンプルなタイマー機能＋レポート機能やタスク機能の付いたもののみで”好き”を原動力にしたものはない（探した時に自分の求めているそういうアプリがなかったので作ろうと思った）

## 実装予定機能（シンプルイズベストでとにかく使いやすさ重視！）
### ■ MVPリリースまでに作っていたい機能
- ユーザー登録機能
- ログイン機能
- ナビキャラクターの画像アップロード機能
- ナビキャラクターによる「ポモドーロテクニックとは何か？」説明（ナビへのメッセージ送信例で表記）
- ポモドーロ作業タイマー（スタート【初期設定：25分】、一時停止、停止）
  - タイマーが0:00になるとリダイレクトで休憩タイマーページに遷移し、休憩タイマーを開始する。ナビからポモドーロサイクル回数と褒めるコメント
- 休憩タイマー（スタート【初期設定：5分】、ポーズ、リセット、終了）
  - タイマーが0:00になるとリダイレクトでポモドーロ作業タイマーページに遷移し、次のポモドーロ作業タイマーを開始する。ナビから応援コメント
- 設定機能
  - ポモドーロ作業時間の変更
  - 休憩時間の変更
  - 長い休憩時間【初期設定：15分】の変更
  - 長い休憩時間までのポモドーロ回数【初期設定：4回】の変更
  - 作業（休憩）タイマーを自動で開始するON/OFF
  - タイマー終了時のアラームON/OFF
  - カラーテーマ変更
- パスワードリセット機能
- アカウント削除機能
- レスポンシブ対応（PCからでもスマホからでも、使いやすくわかりやすいシンプルUI）

### ■ 本リリースまでに作っていたい機能
- レポート機能（本日・週間・月間・年間のポモドーロ作業時間グラフ表示＋累計の作業時間）
  - レポート機能の下部にナビキャラクターのコメントをランダム表示
    - 実装方法：表示させたいコメントをデータベースを作成して入れる！
- X（旧Twitter）へのシェア機能

順次、追加したい機能があれば拡張していく予定。

## 使用技術
**バックエンド**
- Rails 7.1.3.3(Ruby 3.3.1)

**フロントエンド**
- TypeScript
- Next.js
- React

**インフラ**
- Fly.io
- Vercel
- PostgreSQL（データベース）
- Docker（開発環境）

**主要ライブラリ**
- Sorcery（ログイン）
- CarrierWave(画像アップロード)
- vue-cahrtkick(グラフ)
- MetaTags(SEO)
- RSpec(テスト)
- RuboCop(リントチェック)

**その他**
- OpenAI API（ナビキャラクターとの会話、口調設定）
- Google API（Googleログイン）
- Googleアナリティクス(ユーザー解析)

## 画面遷移図
https://www.figma.com/file/YW3sQ5oqfuHa4WP2nLzLT8/PomodoroNavi?node-id=2-4&t=VKcMYAsp3CnvZrFm-1

## ER図
https://gyazo.com/6e55bc8937d7e93461e0770032d46d6e