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
  body.line.each do |l|
   lines << l unless l.length < 80
  end
  lines
 end

 def length
  body.length
 end

 def truncate(limit)
  #@body.skroc unless length < limit  
 end

 def like!
  self.likes += 1
 end

 def dislike!
  self.dislikes += 1
 end

 def points
  self.likes - self.dislikes
 end

 def votes
  self.likes + self.dislikes
 end
end
