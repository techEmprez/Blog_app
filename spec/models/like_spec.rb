require_relative '../rails_helper'

RSpec.describe Like, type: :model do
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
      users: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  let(:like) do
    Like.new(
      users: user,
      posts: post
    )
  end

  it 'is only valid with a user' do
    like.users = user
    expect(like).to be_valid
  end

  it 'is valid with a post' do
    like.posts = post
    expect(like).to be_valid
  end

  it 'updates likes counter after save' do
    like.save
    expect(post.likes_counter).to eq(3)
  end
end
