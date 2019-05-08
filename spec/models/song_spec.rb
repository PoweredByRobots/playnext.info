require 'pry'
require 'rails_helper'

RSpec.describe Song, type: :model do
  it { should validate_presence_of(:artist) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:filename) }
  it { should have_many(:branches) }

  good_data = { artist: 'artist', title: 'title', filename: 'filename', 
                 key_number: '12', key_letter: 'A', bpm: '169' }
  bad_bpm = '999'
  bad_key_letter = 'g'
  bad_key_number = '99'
  bad_key_bpm = { key_letter: bad_key_letter, key_number: bad_key_number, bpm: bad_bpm }
  bad_data = good_data.merge(bad_key_bpm)

  describe '#key' do
    it 'combines the key parts into one when given good data' do
      song = Song.create(good_data)
      expect(song.key).to eq('12A')
    end

    it 'rejects bad data and logs an error' do
      song = Song.create(bad_data) 
      expect(song.errors.messages[:bpm].first).to match /out of range/
    end
  end
end
