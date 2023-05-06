require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'John',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'I am a photographer',
      posts_counter: 4
    )
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    subject.name = 'John'
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    subject.name = 'Jo'
    expect(subject).to_not be_valid
  end

  it 'returns photo if valid' do
    subject.photo = 'https://unsplash.com/photos/F_-0BxGuVvo'
    expect(subject).to be_valid
  end

  it 'is valid with a bio' do
    subject.bio = 'I am a photographer'
    expect(subject).to be_valid
  end

  it 'returns post counter as an integer' do
    subject.posts_counter = 4
    expect(subject).to be_valid
  end

  it 'is not valid if post counter is a string or nil' do
    subject.posts_counter = 5
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end
end
