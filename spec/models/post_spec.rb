require_relative '../rails_helper'

RSpec.describe Post, type: :model do
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

  it 'is not valid without a title' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'is not valid without a text' do
    post.text = 'This is my first post'
    expect(post).to be_valid
  end

  it 'is only valid with a user' do
    post.users = user
    expect(post).to be_valid
  end

  it 'is not valid without a user' do
    post.users = nil
    expect(post).to_not be_valid
  end

  it 'is not valid if comment counter is less than 0' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'is valid if likes counter is 2' do
    post.likes_counter = 2
    expect(post).to be_valid
  end

  it 'updates posts counter after save' do
    post.save
    expect(user.posts_counter).to eq(5)
  end
end
