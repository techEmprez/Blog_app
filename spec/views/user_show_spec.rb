require 'rails_helper'

RSpec.describe 'users_show', type: :feature do
  before :each do
    # create user
    @user = User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit user\'s bio', posts_counter: 0)

    # create posts
    @post = Post.create(title: 'Title 1', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                        likes_counter: 0)
    Post.create(title: 'Title 2', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 3', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 4', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 5', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)

    visit user_url(User.first)
  end

  it 'displays page header' do
    visit user_path(User.first)
    expect(page).to have_text('User Profile Page')
  end

  it "display user's username" do
    expect(page).to have_text('John Doe')
  end

  it 'has the number of posts the user has written' do
    expect(page).to have_text('Number of Posts: 5')
  end

  it "displays user's bio" do
    expect(page).to have_content 'Lorem ipsum dolor sit user\'s bio'
  end

  it 'has button to see all posts' do
    click_on 'See all post', match: :first
    expect(page).to have_current_path user_posts_path(@user.id)
  end
end
