class Article

 def initialize(title,body,author = nil)
  @title, @body, @author = title, body, author
  @created_at = Time.now
  @likes = 0
  @dislikes = 0
 end

 def title
  @title
 end

 def body
  @body
 end

 def author
  @author
 end

 def created_at
  @created_at
 end

 def likes=(value)
  @likes = value
 end
 
 def likes
  @likes
 end 

 def dislikes=(value)
  @dislikes = value
 end

 def dislikes
  @dislikes
 end
end
