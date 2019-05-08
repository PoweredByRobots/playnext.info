require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  describe 'GET search' do
    let(:search_filter) { assigns(:smart_listings)[:songs].params['search_filter'] }
    let(:search_string) { 'yoink' }
    let(:current_song) { assigns(:current_song) }
    let(:song_string) { 'Light my Fire' }
    let(:page_title) { assigns[:page_title] }

    context 'without parameters' do
      before(:example) do
        get :search
      end
      
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end
   
      it 'has no page title or song info' do
        expect(current_song).to be_nil
        expect(page_title).to be_nil
      end
    end
    
    context 'with current_song param' do
      it 'has a page title and song info' do
        params = { current_song: song_string }
        get :search, params: params
      
        expect(current_song).to eq(song_string)
        expect(page_title).to eq(song_string)
      end
    end
    
    context 'with both params' do
      it 'has a page title, current song, and search filter defined' do
        params = { current_song: song_string, 
                    search_filter: search_string }
        get :search, params: params
      
        expect(current_song).to eq(song_string)
        expect(page_title).to eq(song_string)
        expect(search_filter).to eq(search_string)
      end
    end

    context 'with search param' do
      it 'has search filter defined' do
        params = { search_filter: search_string }    
        get :search, params: params
      
        expect(current_song).to be_nil
        expect(page_title).to be_nil
        expect(search_filter).to eq(search_string)
      end
    end
  end
end
