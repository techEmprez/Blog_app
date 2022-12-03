require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.new(
      name: 'John',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'I am a photographer',
      posts_counter: 4
    )
  end

  let(:post) do
    Post.new(
      author: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  let(:comment) do
    Comment.new(
      author: user,
      post: post,
      text: 'Hey!, it is my first comment'
    )
  end

  it 'is not valid without a text' do
    comment.text = 'Hey!, it is my first comment'
    expect(comment).to be_valid
  end

  it 'is only valid with a user' do
    comment.author = user
    expect(comment).to be_valid
  end

  it 'is valid with a post' do
    comment.post = post
    expect(comment).to be_valid
  end

  it 'updates comments counter after save' do
    comment.save
    expect(post.comments_counter).to eq(2)
  end
end
