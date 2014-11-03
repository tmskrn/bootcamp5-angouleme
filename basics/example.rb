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
  lines = []
  body.lines.each do |l|
   lines << l unless l.length < 80
  end
  lines
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
  body.match(pattern) ? true : false 
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
 def initialize(dir)
  @dir = dir
 end
end
