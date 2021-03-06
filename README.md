# Football-Query

https://football-query.com/

### 使用方法

https://football-query.com/use

## サービス概要
アメフトを始めてみたいが何をしたらよいかわからない人、<br>
及び現役選手でコーチなどが不足していて周りに聞く人がいない選手に対し<br>
気軽に質問できる環境を提供するサービス。

## 登場人物
- エンドユーザー
    - アメフト未経験者（初めてはみたいと考えている人）<br>
    - コーチが不足しているチーム等
- 管理者
    - 投稿された質問、回答等に関係ないものはないか調べる

## ユーザーが抱える問題
アメリカンフットボールを始めたいが準備することがわからないことも多くやってみたいが諦めてしまう人もいる。<br>
また始めたもののチームにコーチがあまりおらず練習内容や練習方法がわからないし、聞く人も周りにいないのが現状。<br>
(現に地方の学生はわざわざ関西の強豪校まで足を運んで練習内容などを聞いている）

## 解決方法
気軽にアメリカンフットボールの技術等に関して質問ができ他のユーザーから回答をもらうことができる。<br>
（コミュニティー自体狭いため、様々な回答をもらうことができる）

## プロダクト
気軽にアメリカンフットボールの技術等に関して質問ができ回答をもらうことができるサービス。<br>
回答者に対してもランク等をつけ、回答欲を促す。

## マーケット
特にアメフト未経験者、コーチが不足しているチーム　

## 想い
アメリカンフットボールというスポーツは日本でもマイナースポーツのため、
地方のチームは特にコーチが不足している。<br>
私の現役時代は地方の学生がわざわざお金をかけて練習内容を聞きに来ていた経験がある。<br>
また昨今はコロナも重なりそのような交流もなくなってきているのでさらにアメフトの情報はクローズに
なっていると感じる。<br>
そのため関西や関東のチームと力の差が大きいので少しでも練習内容や方法など聞けるような
プラットフォームがあればと感じこのアプリを作成した。

## 画面遷移図

https://xd.adobe.com/view/fa35923f-5c24-45f3-8a26-299e3fa0053e-af66/

## er図

https://drive.google.com/file/d/1a4c9KjazHe_Cwdok1FjGMutK_E_6l8_E/view?usp=sharing

## 使用技術
### バックエンド
- Ruby 2.6.5
- Rails 5.2.5
- Rspec 4.0.2

### 機能における主要な Gem
- bootstrap
- font-awesome-sass
- jquery-rails
- sorcery（ログイン） 
- ransack（検索）
- kaminari(ページネーション）
- dotenv-rails（環境変数設定）

### インフラストラクチャー
- Nginx 
- unicorn 
- AWS
  - VPC
  - EC2
  - Amazon Linux 2
  - S3
  - ALB
  - Route53
  - ACM
