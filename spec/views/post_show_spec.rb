require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          posts_counter: 0)
      @user2 = User.create(name: 'Mohammed', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher Pakistan.',
                           posts_counter: 0)
      @post = Post.create(author: @user, title: 'Hello One', text: 'This is my first post', likes_counter: 0,
                          comments_counter: 0)
      @comment1 = Comment.create(author: @user, post: @post, text: 'I like this post comment one')
      @comment2 = Comment.create(author: @user2, post: @post, text: 'I like this post comment two')
      @comment3 = Comment.create(author: @user2, post: @post, text: 'I like this post comment three')

      visit user_post_path(@user, @post)
    end

    it "renders the post's title" do
      expect(page).to have_content(@post.title)
    end

    it "renders the post's author" do
      expect(page).to have_content(@user.name)
    end

    it 'renders comments count of the post' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'renders likes count of the post' do
      expect(page).to have_content(@post.likes_counter)
    end

    it "renders the post's body" do
      expect(page).to have_content(@post.text)
    end

    it 'renders the username of each commenter' do
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user.name)
    end

    it 'renders all comments of the post' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end
  end
end
