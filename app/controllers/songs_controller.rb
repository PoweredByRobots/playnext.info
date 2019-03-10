# All things song-related
class SongsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def search
    @current_song = params[:current_song]
    @page_title = @current_song
    song_scope = Song.all
    puts "*** Search filter: #{params[:search_filter]} ***"
    song_scope = song_scope.where("title LIKE '%#{params[:search_filter]}%'") if params[:search_filter]
    @songs = smart_listing_create :songs,
                                  song_scope,
                                  partial: 'songs/listing',
                                  sort_attributes: [
                                    [:artist, 'artist'],
                                    [:title, 'title'],
                                    [:year, 'year'],
                                    [:bpm, 'bpm'],
                                    [:energy, 'energy']
                                  ],
                                  default_sort: { artist: 'asc' },
                                  array: true
  end
end
