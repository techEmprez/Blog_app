require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  subject do
    Post.create(id: '1', title: 'Post1', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                author_id: 1)
  end
  describe 'GET #index' do
    before(:each) { get '/users/:user_id/posts' } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('List all sent posts')
    end
  end

  describe 'GET #show' do
    before(:each) { get '/users/:user_id/posts/:id' } # get(:show)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('Show Posts')
    end
  end
end
