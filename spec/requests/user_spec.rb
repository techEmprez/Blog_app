require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }
  describe 'GET #index' do
    before(:each) { get users_path } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('All Users')
    end
  end

  describe 'GET #show' do
    before(:each) { get '/users/2' } # get(:show)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('single User Page')
    end
  end
end
