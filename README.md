# インストール手順

## 1.準備(どれから始めてもOK)

### インストール先のディレクトリを作る

 ```
  $ INSTALL_DIR=/var/www/login
  $ mkdir $INSTALL_DIR
  $ chown deploy-user: $INSTALL_DIR
 ```

### 鍵を設定する
* $HOME/.ssh/orange-tieにデプロイ鍵を置く。

* $HOME/.ssh/configに以下を追記

  ```
  Host bitbucket.org
    User git
    Hostname bitbucket.org
    IdentityFile ~/.ssh/orange-tie
    TCPKeepAlive yes
    IdentitiesOnly yes
  ```

### データベースを作成する

 developmentとproductionどちらも作ること。

```
  CREATE DATABASE tie3;
  CREATE DATABASE tie3dev;
  GRANT ALL PRIVILEGES ON tie3.* TO jitsui@localhost IDENTIFIED BY 'hogehoge';
  GRANT ALL PRIVILEGES ON tie3dev.* TO jitsui@localhost;
```


## 2.設定ファイルを編集する

  データベースで作成したユーザ/パスワードをココに書く
  ここの情報を元にapp/Config/constants.phpが生成されます
(つまり__絶対に__直接編集するなということ)

  ```
  $ cp common.sh.template common.sh
  $ vim common.sh
  ```

## 3.init.shを実行する
  よろしくお願いしまあぁぁぁぁぁあぁす！！！！

## 4.apacheのconf編集
以下を追記

  ```
  <VirtualHost *:80>
    ServerName [DOMAIN_FOR_DEVELOPMENT]
    RewriteEngine On
    DocumentRoot [INSTALL_DIR]/development
    <Directory />
      Options FollowSymLinks
      AllowOverride All
      </Directory>
  </VirtualHost>
  <VirtualHost *:80>
    ServerName [DOMAIN_FOR_PRODUCTION]
    RewriteEngine On
    DocumentRoot [INSTALL_DIR]/production
    <Directory />
      Options FollowSymLinks
      AllowOverride All
    </Directory>
  </VirtualHost>
  ```

## 5.おわり
楽しい！！ ✌('ω'✌ )三✌('ω')✌三( ✌'ω')✌

