# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('http://newsapi.org/v2/everything?q=bitcoin&from=2020-05-04&sortBy=publishedAt&apiKey=7ddd0e045b2c4804846a868535a6c376')
request = Net::HTTP::Get.new(uri)
request.content_type = 'application/json'

@response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end

info = @response.body

info.force_encoding('utf-8')

File.write('article.json', info)

file = File.read('article.json')

articles = JSON.load(file)['articles']

articles.each do |article|
  Article.create(title: article['title'], content: article['description'])
end
