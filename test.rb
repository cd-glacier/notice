require "./adapt_ADE.rb"
require "./notice.rb"
@client = connect_adapted_mysql()

s = "https://ja.wix.com/support/html5/article/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%82%92%E5%90%AB%E3%82%80url%E3%82%92%E3%83%AA%E3%83%B3%E3%82%AF%E5%85%88%E3%81%AB%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95"
adress = "hyoga0216@gmail.com"
p = "https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%90%8D"

notice(10, p, "net", adress)


