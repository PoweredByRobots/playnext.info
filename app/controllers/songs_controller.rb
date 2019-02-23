# All things song-related
class SongsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def search
    @page_title = 'current song'
    @songs = smart_listing_create(:songs, Song.all, partial: 'songs/listing')
  end
end
