require 'net/http'
require 'uri'

tor_exits_url = 'https://check.torproject.org/exit-addresses'
start_time = Time.now
raw_tor_exits = Net::HTTP.get(URI.parse(tor_exits_url))

if raw_tor_exits
  ips = raw_tor_exits.scan(/\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/)
  if ips
    filename = "tor-list-#{Time.now.to_i}.txt"
    write_to_file = File.open(filename, 'w') { |file| file.write(ips) }
    end_time = Time.now
    if write_to_file
      puts "Successfully written to #{filename} with #{ips.count} IP addresses in #{end_time - start_time} sec(s)"
    else
      puts "Can't store IP addresses to #{filename}"
    end
  else
    puts "Can't extract IP addresses form raw data"
  end
else
  puts "Can't get raw Tor IPs"
end

