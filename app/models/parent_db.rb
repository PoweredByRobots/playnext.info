require 'io/console'

# Handle data from another source
class ParentDb
  attr_reader :client

  def export_all
    @overwrite = prompt_to_overwrite? ? true : false
    songs.each { |song| export(song) }
  end

  private

  def music_path
    'Z:/The Talent/Music/'
  end

  def prompt_to_overwrite?
    print 'Overwrite existing records? (y/n) ==> '
    STDIN.getch == 'y'
  end

  def local_match?(song)
    return false if @overwrite == true
    !Song.where(artist: song['artist'], title: song['title']).empty?
  end

  def export(song)
    return if local_match?(song)
    Song.create(convert(song))
  end

  def songs
    client.query(query)
  end

  def query
    "SELECT #{fields_of_interest.join(', ')} FROM #{db_name} WHERE #{criteria}"
  end

  def fields_of_interest
    %w(artist title album albumyear genre info bpm grouping energy filename)
  end

  def db_name
    'songlist'
  end

  def criteria
    "songtype = 'S' AND hours_off < 9999"
  end

  def convert(song)
    { artist: song['artist'],
      title: song['title'],
      album: song['album'],
      year: song['albumyear'],
      energy: calculate_energry(song),
      key_number: number_from_key(song['info']),
      key_letter: letter_from_key(song['info']),
      bpm: song['bpm'],
      genres: song['grouping'],
      filename: win_to_mac(song['filename']) }
  end

  def win_to_mac(filename)
    mac_filename = filename.tr '\\', '/'
    mac_filename.delete_prefix music_path
  end

  def to_energy
    { '5000' => 90,
      '4000' => 70,
      '3000' => 50,
      '2000' => 30,
      '1000' => 10 }
  end

  def number_from_key(key)
    key.gsub(/[^\d]/, '')
  end

  def letter_from_key(key)
    key.gsub(/[^\[A-Ba-b]/, '')
  end

  def calculate_energry(song)
    return song['energy'] unless song['energy'].nil?
    to_energy[song['genre']]
  end

  def client
    @client ||= Mysql2::Client.new(credentials)
  end

  def credentials
    { host: ENV['SONGS_DB_HOSTNAME'],
      username: ENV['SONGS_DB_USER'],
      password: ENV['SONGS_DB_PWD'],
      database: ENV['SONGS_DB_NAME'] }
  end
end
