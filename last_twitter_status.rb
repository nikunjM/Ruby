require 'twitter'
#load 'twitter_config.rb'
#Create seprate config file.
#Encrprty ur keys using md5.

client = Twitter::REST::Client.new do |config|
  config.consumer_key = "3OpBStixWSMAzBttp6UWON7QA"
  config.consumer_secret = "MBmfQXoHLY61hYHzGYU8n69sQRQPheXJDejP1SKE2LBdgaqRg4"
  config.access_token = "322718806-qScub4diRzggWUO9DaLKMVKwXZcgrqHD2OFbwQTr"
  config.access_token_secret = "aWAIxQVnqF3nracQ0cC0HbRbSDxlCAaUIICorEAPlxIub"
end

#add authentication for different users.
print "please Enter the key word you want to follow?"
keyword_value= gets.chomp;
print "Enter the tweets or follows you want to find "
print "for ex number from 1- 100";
count_number = gets.chomp;
count=1;
#validate user inputs, using reg exp.

client.search(keyword_value, result_type: "recent").take(Integer(count_number)).collect do |tweet|
  puts "Count       Username  				tweet"           
  puts "(#{tweet.url})    #{tweet.user.screen_name} #{tweet.text}";
  sleep(3);
  count=count+1;
  #before following user check if its alreay in list using bollean.	
  client.follow("#{tweet.user.screen_name}")
  #client.favorite.create("#{tweet.user.screen_name}")
   client.favorites("#{tweet.id}","#{tweet.user.screen_name}",tweet.url)
end


#https://dev.twitter.com/oauth/tools/signature-generator/8187227?nid=820
#the above link is for oAuth and can be used for signing of new user.
#Can request a json file and also post a tweet.
#https://dev.twitter.com/rest/reference/post/favorites/create



