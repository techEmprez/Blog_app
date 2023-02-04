require 'rails_helper'

RSpec.describe 'users_index', type: :feature do
  before :each do
    User.create(name: 'John Doe', photo: 'http//p.png', bio: 'Lorem ipsum dolor sit', posts_counter: 0)
    User.create(name: 'Mary Williams', photo: 'http//p1.png', bio: 'Lorem ipsum dolor', posts_counter: 0)
  end

  it 'displays page header' do
    visit users_path
    expect(page).to have_text('List all users')
  end

  it 'displays all users' do
    visit users_path
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Mary Williams'
  end

  it 'should have the profile picture' do
    visit users_path
    expect(page).to have_xpath("//img[contains(@src,'http//p.png')]")
    expect(page).to have_xpath("//img[contains(@src,'http//p1.png')]")
  end

  it 'should have number of users post' do
    visit users_path
    expect(page).to have_content('Number of Posts: 0')
  end

  it 'it redirect to user show page' do
    visit users_path
    expect(page).to have_link 'More info', href: user_path(User.first)
  end
end
