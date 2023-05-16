require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) do
      user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am techEmprez',
                          posts_counter: 1)
      get "/users/#{user.id}/posts"
    end
    it 'is a success' do
      expect(response).to have_http_status(200)
    end
    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('<h2>Here is a list of all posts of a given user</h2>')
    end
  end

  describe 'GET #show' do
    before(:each) do
      user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am techEmprez',
                          posts_counter: 1)
      post = Post.create!(author: user, title: 'First Post', text: 'This is a the first post.',
                          comments_counter: 0, likes_counter: 0)
      get "/users/#{user.id}/posts/#{post.id}"
    end
    it 'is a success' do
      expect(response).to have_http_status(200)
    end
    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('<h2>Here is one post</h2>')
    end
  end
end
