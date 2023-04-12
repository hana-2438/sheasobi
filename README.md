# しぇあそび

## サイト概要
### サイトテーマ
小さな子供と遊べる場所を検索したり、投稿できるSNSサイト

### テーマを選んだ理由
子供と出かけることが好きなのですが、いつも同じ公園や施設に行くことが多く、遊ぶ場所に悩むことが多くありました。
子育て中の友人も多くおりますので、同じ悩みを持っているのではないかと考えました。
また、主観ではありますが新型コロナウイルスの影響での外出自粛も少しずつ緩和されているように感じますので、
外出や旅行など楽しまれる方が増え、経済効果も見込めると思い、このテーマを選びました。

### ターゲットユーザ
- 小さな子供を持つお父さんやお母さんなど
- お気に入りのお出かけスポットなどを投稿したい人
- 旅行先でのお出かけスポットを探したい人
- 遊ぶ場所のレパートリーがなくて困っている人

### 主な利用シーン
- おすすめのお出かけ先などを投稿するとき
- 小さな子供を連れてお出かけするとき
- 出かける場所などに困ったとき
- 旅行先の穴場スポットなどを探すとき

### サイトイメージ
![サイトイメージ画像](https://user-images.githubusercontent.com/121591703/226815747-3924a73f-cfba-42b1-af12-9a7557a67aa7.png)

### サイトURL

## 機能一覧
### 認証機能（devise）
- ユーザー登録
- ログイン
- ログアウト
- ゲストログイン
- 管理者ログイン

### 基本機能（会員側）
- おでかけスポットの投稿（CRUD処理、Kaminariによるページネーション）
- コメント機能（非同期通信）
- 投稿及びユーザーの検索機能（キーワード検索）
- タグ検索機能
- いいね（ブックマーク）機能（非同期通信）
- いいね（ブックマーク）一覧表示機能
- フォロー機能（非同期通信）
- お問い合わせ機能(Action Mailer)
- 通報機能（ActionMailerで通報されたユーザーにメールを送信できるようにしています）

### 基本機能（管理者側）
- 会員情報編集機能（論理削除での退会処理）
- タグ機能（CRUD処理）

### 今後実装したいもの
- 通報機能で通報されたユーザーに管理者側からメールを送れるようにしたい
- 画像圧縮のAPI導入
- ドメイン取得、HTTPS化

## 設計書
- [ER図](https://app.diagrams.net/#G1uO7tofLJ1SxcwdzJUW_r_oqATsKXfxMo)
- [テーブル設計書](https://docs.google.com/spreadsheets/d/1prkBJ2XOGMMfO4rm8_2quiNzTtHXJ75eAbAPaDW3ygM/edit#gid=1694275998)
- [画面遷移図](https://app.diagrams.net/?src=about#G13lib6irPyT1CaeK1piZzEAq8fwdJCs9C)
- [ワイヤーフレーム](https://app.diagrams.net/#G1IkgI8xQfS-GxPjhTIKwKl-WONR2rN-Mq)
- [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1R-PqeMMwks32SA2XalqWpNWCHmHcrTBnGjN2AaPBtkE/edit#gid=1447071290)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## インフラ構成図
![AWSインフラ構成](https://user-images.githubusercontent.com/121591703/226816407-976786d9-751b-4b76-bc61-c4870f43095e.png)

## 使用素材
- フリー素材ブログ（no image画像）