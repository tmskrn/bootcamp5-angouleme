require 'minitest/autorun'
require './broken_example.rb'
#require './article.rb'

class ArticleTest < Minitest::Test
  def test_initialization
   article = Article.new('some title', 'some body', 'some author')
   assert_equal "some title", article.title
   assert_equal "some body", article.body
   assert_equal "some author", article.author
   assert_equal 0, article.likes 
   assert_equal 0, article.dislikes
  end

  def test_initialization_with_anonymous_author
   article = Article.new('some title', 'some body')
   assert_equal "some title", article.title
   assert_equal "some body", article.body
   assert_nil(article.author)    
  end

  def test_liking
   article = Article.new('title', 'body','author')
   assert_equal 0, article.likes
   article.like!
   assert_equal 1, article.likes
   assert_equal 1, article.points
   assert_equal 1, article.votes
  end

  def test_disliking
   article = Article.new('title', 'body', 'author')
   assert_equal 0, article.likes
   assert_equal 0, article.dislikes
   2.times do article.dislike! end
   assert_equal 2, article.dislikes
  end

  def test_points
   article = Article.new('title', 'body', 'author')
   assert_equal 0, article.likes
   assert_equal 0, article.dislikes
   assert_equal 0, article.points
  
   2.times do article.like! end
   3.times do article.dislike! end
   assert_equal -1, article.points
  end

  def test_long_lines
   long_line1 = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget.\n" # 85 char long
   long_line2 = "But I must explain to you how all this mistaken idea of denouncing pleasure and praiss\n" #86 char long
   short_line = "short line\n"
   body = long_line1 + long_line2 + short_line
   article = Article.new('title', body, 'author')
 
   long_lines = article.long_lines
   assert_instance_of Array, long_lines
   assert_equal 2, long_lines.count  
  end

  def test_truncate
   body = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget?!" # 86 char long
   limit = 16
   article = Article.new('title', body, 'author')
   assert_equal limit, article.truncate(limit).length
   assert_equal "...", article.truncate(limit)[13..16]
  end

  def test_truncate_when_limit_is_longer_then_body
   body = "abcdef" # 6 char long
   article = Article.new('title', body, 'author')
   limit = 10
   assert_equal body.length, article.truncate(limit).length
   assert_equal "def", article.truncate(limit)[3..6]
  end

  def test_truncate_when_limit_is_same_as_body_length
   body = "abcdef"
   article = Article.new('title', body, 'author')
   limit = 6
   assert_equal body.length, article.truncate(limit).length
   assert_equal "def", article.truncate(limit)[3..6]
  end

  def test_length
   body = "abcdef"
   article = Article.new('title', body, 'author')

   assert_equal body.length, article.length
  end

  def test_votes
   article = Article.new('title', 'body', 'author')
   assert_equal 0, article.likes
   assert_equal 0, article.dislikes

   3.times do article.like! end
   7.times do article.dislike! end

   assert_equal 10, article.votes
  end

  def test_contain
   body = "hola hola"
   article = Article.new('title', body, 'author')
   
   assert_equal true, article.contain?("hola")
   assert_equal true, article.contain?(/ ho(.*)/) 
  end

end
