#webサイト通知サービス
一応動いている

 > http://glacier.space/notice 

domainは変える予定

### 参考になったサイトたち（自分用）

#### sinatra unicorn

 > http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn


#### clockwork(変えるかも)

 > http://qiita.com/giiko_/items/7e7c91a50f66bb351c89


#### mail

 > http://www.school.ctc-g.co.jp/columns/masuidrive/masuidrive07.html

### Usage

```
 clockworkd -c clock.rb start --log
```

```
unicorn -c unicorn.rb -E development -D
```
