require 'minitest/autorun'
#require './broken_example.rb'
require './article.rb'

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
   #article = Article.new('title', 'body','author')
  end

  def test_disliking
  end

  def test_points
  end

  def test_long_lines
  end

  def test_truncate
  end

  def test_truncate_when_limit_is_longer_then_body
  end

  def test_truncate_when_limit_is_same_as_body_length
  end

  def test_length
  end

  def test_votes
  end

  def test_contain
  end

end
