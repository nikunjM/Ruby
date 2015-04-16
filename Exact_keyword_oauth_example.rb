# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require 'oauth'
require 'twitter'

# Initialisation based on string values:
#end
client = Twitter::REST::Client.new do |config|
  config.consumer_key = "3OpBStixWSMAzBttp6UWON7QA"
  config.consumer_secret = "MBmfQXoHLY61hYHzGYU8n69sQRQPheXJDejP1SKE2LBdgaqRg4"
  config.access_token = "322718806-qScub4diRzggWUO9DaLKMVKwXZcgrqHD2OFbwQTr"
  config.access_token_secret = "aWAIxQVnqF3nracQ0cC0HbRbSDxlCAaUIICorEAPlxIub"
end

consumer_key = '3OpBStixWSMAzBttp6UWON7QA'
consumer_secret = 'MBmfQXoHLY61hYHzGYU8n69sQRQPheXJDejP1SKE2LBdgaqRg4'
access_token = '322718806-qScub4diRzggWUO9DaLKMVKwXZcgrqHD2OFbwQTr'
access_token_secret = 'aWAIxQVnqF3nracQ0cC0HbRbSDxlCAaUIICorEAPlxIub'

@consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site=>'https://api.twitter.com'})
accesstoken = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)

print "please enter phrase you want to search"
phrase_value=gets.chomp;
request_uri = "https://api.twitter.com/1.1/search/tweets.json?q=";
request_query = ''
#url = request_uri + URI::encode(phrase_value);
url="#{request_uri}\"#{phrase_value}\""
#url.gsub!(' ','%20')
print url;

response = accesstoken.get(url,{ 'Accept' => 'application/xml' });

json = JSON.parse(response.body);
total = json['statuses'];
sample = File.open("simple_file.json",  "w+");
sample.puts(json);
sample.close;

count=0;
total.each do |alerts|
puts "#{alerts['user']['screen_name']}";
client.follow("#{alerts['user']['screen_name']}");
client.fav alerts;
sleep(3);
end
puts "Finished!\n\n"
