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
 
end
