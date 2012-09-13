require 'nokogiri'
require 'open-uri'

BASE_URL = 'http://www.cifraclub.com.br/'

artists_filename = ARGV[0] || 'artists.txt'
begin
  artists_slang = File.readlines(File.expand_path(artists_filename))
    .map { |slang| slang.strip }
    .reject { |slang| slang.empty? || slang[0] == '#' }
rescue
  abort "FAIL file #{artists_filename} not found"
end
artists_slang.each do |artist_slang|
  Dir.mkdir artist_slang unless File.directory?(artist_slang)
  Dir.chdir artist_slang do
    begin
      puts "Retrieving list #{artist_slang}"
      list_html = Nokogiri::HTML(open(BASE_URL + artist_slang))
    rescue
      puts "FAIL retrieve list #{artist_slang}"
      next
    end
    links = list_html.css('.ac_ol_a')
    if links.empty?
      puts "FAIL no list for #{artist_slang}"
      next
    end
    links.each do |tab_link|
      href = tab_link.attr 'href'
      if href =~ /^\/[^\/]+\/[^\/]+\/$/
        song_slang = href.split('/').last
        begin
          puts "Retrieving tab #{artist_slang} - #{song_slang}"
          tab_html = Nokogiri::HTML(open(BASE_URL + href))
        rescue
          puts "FAIL retrieve tab #{artist_slang} - #{song_slang}"
          next
        end
        artist_html = tab_html.css('#ai_artista')
        song_html   = tab_html.css('#ai_musica')
        tab_html    = tab_html.css('#cifra_cnt')
        if artist_html.empty? || song_html.empty? || tab_html.empty?
          puts "FAIL no tab for #{artist_slang} - #{song_slang}"
          next
        end
        artist = artist_html.first.content
        song   = song_html.first.content
        tab    = tab_html.first.content

        filename = "#{song_slang}.txt"
        i = 2
        while File.exists? filename
          filename = "#{song_slang}-#{i}.txt"
          i += 1
        end
        File.open filename, 'w' do |file|
          file.write "#{artist}\n=========================\n\n#{song}\n------------------------\n\n#{tab}"
        end
        puts "#{artist} - #{song} saved"
        sleep 1 # don't flood your friend :D
      end
    end
  end
end
