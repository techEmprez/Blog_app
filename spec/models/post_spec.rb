require 'rails_helper'

describe Post, type: :model do
  before :each do
    @author = User.new(name: 'Musa', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software dev from Nigeria')
    @post = Post.new(author: @author, title: 'My first post', text: 'This is my very first post on this app',
                     comments_counter: 0)
  end

  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should not be empty' do
    @post.title = ''
    expect(@post).to_not be_valid
  end

  it 'title should have a maximum of 250 characters' do
    @post.title =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
      Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
     when an unknown printer took a galley of type and scrambled it to make a type
       specimen book. It has survived not only five centuries, but also the leap
       into electronic typesetting, remaining essentially unchanged. It was
       popularised in the 1960s with the release of Letraset sheets containing
        Lorem Ipsum passages, and more recently with desktop publishing software
         like Aldus PageMaker including versions of Lorem Ipsum"

    expect(@post).to_not be_valid
  end

  it 'comments_counter should be set to 0 by default' do
    expect(@post.comments_counter).to eq 0
    expect(@post).to be_valid
  end

  it 'likes_counter should be set to 0 by default' do
    expect(@post.likes_counter).to eq 0
    expect(@post).to be_valid
  end

  it 'comments_counter should be greater then or equal to 0' do
    @post.comments_counter = -10
    expect(@post).to_not be_valid
  end

  it 'has its likes_counter greater than or equal to 0' do
    @post.likes_counter = -10
    expect(@post).to_not be_valid
  end

  it 'has the recent 5 comments after it creates 10 comments' do
    10.times { |time| Comment.create(author: @author, post: @post, text: "Test comment #{time + 1}") }
    expect(@post.fetch_recent_comments.length).to eq 5

    recent_comment_text = @post.fetch_recent_comments.first.text
    expect(recent_comment_text).to match 'Test comment 10'
  end

  it "can not update posts_counter since it's a private method" do
    expect(@post).to_not respond_to(:update_posts_counter)
  end
end
