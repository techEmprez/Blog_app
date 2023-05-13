require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'is a success' do
      get users_path
      expect(response).to have_http_status(200)
    end
    it "renders 'index' template" do
      get users_path
      expect(response).to render_template(:index)
    end
    it 'includes the correct placeholder text' do
      get users_path
      expect(response.body).to include('<h2>Here is a list of all users</h2>')
    end
  end

  describe 'GET #show' do
    it 'is a success' do
      user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am techemprez, currently with Microverse studying for fullstack developement..',
                            posts_counter: 1)
        get "/users/#{user.id}"
        expect(response).to be_successful
        expect(response.body).to include('<h2>Here is a user</h2>')
        expect(response).to render_template(:show)
    end
  end
end
