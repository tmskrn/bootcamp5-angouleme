require 'pry'

class Article
 attr_accessor :likes, :dislikes
 attr_reader :title, :body, :author, :created_at

 def initialize(title, body, author = nil)
  @title, @body, @author = title, body, author
  @created_at = Time.now
  @likes = 0
  @dislikes = 0
 end

 def long_lines 
  body.lines.select!{|line| line.length > 80}
 end

 def length
  body.length
 end

 def truncate(limit)
  if length > limit  
   cut = length - limit
   @body = @body[0...-cut-3] << "..."
  else
   @body 
  end
  
 end

 def contain?(pattern)
  !!body.match(pattern)
 end

 def like!
  self.likes += 1
 end

 def dislike!
  self.dislikes += 1
 end

 def points
  likes - dislikes
 end

 def votes
  likes + dislikes
 end
end

class ArticlesFileSystem
 attr_reader :dir

 def initialize(dir)
  @dir = dir
 end

 def save(articles)
  articles.each do |article|
   path = dir + '/' + article.title.gsub(/\s/, '_').downcase + '.article'
   file = File.open( path,"w")
   file.write(article.author + '||' + article.likes.to_s + '||' + article.dislikes.to_s + '||' + article.body)
   file.close 
  end
 end

 def load
  list = Dir.entries(dir).select!{|article| article.include?(".article")} 
  articles = []
  list.each do |file|
   title, extension = file.chomp.split(".") 
   #title = Pathname.new(file).basename('.article') 
   author, likes, dislikes, body =  File.open(dir + '/' + file).read.chomp.split('||')
   a = Article.new(title.gsub('_',' ').capitalize, body, author) 
   a.likes, a.dislikes = likes.to_i, dislikes.to_i
   articles << a
  end
  articles
 end 
end

class WebPage
 attr_reader :dir

 def initialize(dir = '/') 
  @dir = dir 
  @articles = []
 end

 def articles
  @articles
 end

 def load 
  @articles = ArticlesFileSystem.new(dir).load
 end

 def save(articles)
  ArticlesFileSystem.new(dir).save(articles)
 end
 
 def new_article(title, body, author)
   new_article = Article.new(title, body, author)
   articles << new_article
   new_article
 end

end
