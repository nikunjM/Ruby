# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require 'oauth'
require 'twitter'

#load 'twitter_config.rb'
#Create seprate config file.
#Encrprty ur keys using md5.
=begin
client = Twitter::REST::Client.new do |config|
  config.consumer_key = "3OpBStixWSMAzBttp6UWON7QA"
  config.consumer_secret = "MBmfQXoHLY61hYHzGYU8n69sQRQPheXJDejP1SKE2LBdgaqRg4"
  config.access_token = "322718806-qScub4diRzggWUO9DaLKMVKwXZcgrqHD2OFbwQTr"
  config.access_token_secret = "aWAIxQVnqF3nracQ0cC0HbRbSDxlCAaUIICorEAPlxIub"
=end
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
#print response.body;
objArray = JSON.parse(response.body)

sample = File.open("simple_file.json",  "w+");
sample.puts(response.body);
sample.close;


objArray.each do |tweet|
  puts "Count       Username  				tweet"           
  puts "(#{tweet.url})    #{tweet.user.screen_name} #{tweet.text}";
  #sleep(3);
  #count=count+1;
  #before following user check if its alreay in list using bollean.	
  client.follow("#{tweet.user.screen_name}")
end

=begin
result = JSON.parse(sample)
# An example of how to take a random sample of elements from an array. Pass the number of elements you want into .sample() method. It's probably a better idea for the server to limit the results before sending, but you can use basic Ruby skills to trim & modify the data however you'd like.
 
# Loop through each of the elements in the 'result' Array & print some of their attributes.
 result.each do |tweet|
  puts "Count       Username  				tweet"           
  puts "(#{tweet.url})    #{tweet.user.screen_name} #{tweet.text}";
  #sleep(3);
  #count=count+1;
  #before following user check if its alreay in list using bollean.	
  client.follow("#{tweet.user.screen_name}")
end
=end
=begin
# Perform the HTTP GET request, and return the response
resp = Net::HTTP.get_response(URI.parse(url))


# Parse the JSON from the response body
jresp = JSON.parse(resp.body)
print jresp;
=end
=begin 
# Construct the URL we'll be calling
print "please enter phrase you want to search"
phrase_value=gets.chomp;
#pets = File.open("https://api.twitter.com/1.1/search/tweets.json?q=#{phrase_value}", "r");

request_uri = "https://api.twitter.com/1.1/search/tweets.json?q=";
request_query = ''
url = "#{request_uri}#{phrase_value}"
url.gsub!(' ','%20')
print url;
 
# Actually fetch the contents of the remote URL as a String.
buffer = open(url).read
  
# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
result = JSON.parse(buffer)
# An example of how to take a random sample of elements from an array. Pass the number of elements you want into .sample() method. It's probably a better idea for the server to limit the results before sending, but you can use basic Ruby skills to trim & modify the data however you'd like.
result = result.sample(5)
 
# Loop through each of the elements in the 'result' Array & print some of their attributes.
 result.each do |tweet|
  puts "Count       Username  				tweet"           
  puts "(#{tweet.url})    #{tweet.user.screen_name} #{tweet.text}";
  #sleep(3);
  #count=count+1;
  #before following user check if its alreay in list using bollean.	
  client.follow("#{tweet.user.screen_name}")
end
=end
puts "Finished!\n\n"
