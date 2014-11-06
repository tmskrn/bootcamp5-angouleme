require 'minitest/autorun'
require './broken_example.rb'
#require './article.rb'

class ArticleTest < Minitest::Test
  def setup
   @article = Article.new('some title', 'some body', 'some author')
   assert_equal 0, @article.likes
   assert_equal 0, @article.dislikes
   assert_equal 0, @article.points
   assert_equal 0, @article.votes
  end

  def test_initialization
   assert_equal "some title", @article.title
   assert_equal "some body", @article.body
   assert_equal "some author", @article.author
  end

  def test_initialization_with_anonymous_author
   @article = Article.new('some title', 'some body')

   assert_equal "some title", @article.title
   assert_equal "some body", @article.body
   assert_nil(@article.author)    
  end

  def test_liking
   @article.like!
   assert_equal 1, @article.likes
  end

  def test_disliking
   2.times {@article.dislike!}
   assert_equal 2, @article.dislikes
  end

  def test_points
   2.times {@article.like!}
   3.times {@article.dislike!}
   assert_equal -1, @article.points
  end

  def test_long_lines
   long_line1 = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget.\n" # 85 char long
   long_line2 = "But I must explain to you how all this mistaken idea of denouncing pleasure and praiss\n" #86 char long
   short_line = "short line\n"
   @article = Article.new('title', long_line1 + long_line2 + short_line, 'author')

   assert_equal [long_line1, long_line2], @article.long_lines  
  end

  def test_truncate
   article = Article.new('title', 'Lorem ipsum dolor sit amet', 'author')
   assert_equal "Lorem ipsum d...", article.truncate(16)
  end

  def test_truncate_when_limit_is_longer_then_body
   @article = Article.new('title', "abcdef", 'author')
   assert_equal "abcdef", @article.truncate(10)
  end

  def test_truncate_when_limit_is_same_as_body_length
   @article = Article.new('title', 'abcdef', 'author')

   assert_equal 'abcdef', @article.truncate(6)
  end

  def test_length
   article = Article.new('title', 'abcdef', 'author')
   assert_equal 'abcdef'.length, article.length
  end

  def test_votes
   3.times {@article.like!}
   7.times {@article.dislike!}

   assert_equal 10, @article.votes
  end

  def test_contain
   @article = Article.new('title', 'hola hola', 'author')
   
   assert_equal true, @article.contain?("hola")
   assert_equal true, @article.contain?(/ ho(.*)/) 
   assert_equal false, @article.contain?("boom")
   assert_equal false, @article.contain?(/\A k(.*)/)
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def test_saving
  end

  def test_loading
  end
end
