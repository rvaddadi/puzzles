require 'net/http'
require 'uri'

SITE = 'http://www.icmc.usp.br'
REGEXP_URL =    /<a .*?href="(.+?)".*?>/i
REGEXP_EMAILS = /\b([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})\b/i
urls = [SITE]
all_emails = []
i = 0
while url = urls[i]
  begin
    i += 1
    puts 'Scanning ' + url
    page = Net::HTTP.get URI.parse url
    emails = page.scan(REGEXP_EMAILS).map { |email| email[0] }
    urls +=  page.scan(REGEXP_URL).map do |url|
      if url[0][0] == '/' then SITE + url[0] else url[0] end
    end
    urls.uniq!
    File.open('emails.txt', 'a') do |file|
      emails.each do |email|
        unless all_emails.include? email
          file.write(email + "\n")
          all_emails << email
        end
      end
    end unless emails.empty?
  rescue
    puts 'Invalid URL ' + url
  end
end
