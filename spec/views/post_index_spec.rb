require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software engineer.',
                          posts_counter: 0)
      @post1 = Post.create(author: @user, title: 'Hello First Post', text: 'This is my first post', likes_counter: 0,
                           comments_counter: 0)
      @post2 = Post.create(author: @user, title: 'Hello Second Post', text: 'This is my second post', likes_counter: 0,
                           comments_counter: 0)
      @post3 = Post.create(author: @user, title: 'Hello Third Post', text: 'This is my third post', likes_counter: 0,
                           comments_counter: 0)
      @post4 = Post.create(author: @user, title: 'Hello Fourth Post', text: 'This is my fourth post', likes_counter: 0,
                           comments_counter: 0)
      @comment1 = Comment.create(author: @user, post: @post2, text: 'I like this post')
      @comment2 = Comment.create(author: @user, post: @post2, text: 'I like this post')
      @comment3 = Comment.create(author: @user, post: @post1, text: 'I like this post')
      @comment4 = Comment.create(author: @user, post: @post1, text: 'I like this post')
      @comment5 = Comment.create(author: @user, post: @post1, text: 'I like this post')

      visit user_posts_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.posts_counter)
    end

    it "renders the user's posts" do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end

    it "renders some of the post's body" do
      expect(page).to have_content(@post1.text[0, 50])
      expect(page).to have_content(@post2.text[0, 50])
      expect(page).to have_content(@post3.text[0, 50])
    end

    it 'renders first comments on a post' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end

    it 'renders comments count on a post' do
      expect(page).to have_content(@post1.comments_counter)
      expect(page).to have_content(@post2.comments_counter)
      expect(page).to have_content(@post3.comments_counter)
    end

    it 'renders likes count on a post' do
      expect(page).to have_content(@post1.likes_counter)
      expect(page).to have_content(@post2.likes_counter)
      expect(page).to have_content(@post3.likes_counter)
    end

    it "redirects to a post's show page" do
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@user.id, @post1.id))
    end
  end
end