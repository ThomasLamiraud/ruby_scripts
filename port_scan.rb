require 'logger'
require 'ipaddr'
require 'timeout'
require 'socket'


puts "Port Scanner"
puts "IP Address to scan: "
adress = gets.chomp

re = "^(192\.168\.([0,1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([0,1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]))$"

def ping(host)
  begin
    Timeout.timeout(5) do
      s = TCPSocket.new(host, 'echo')
      s.close
      return true
    end
  rescue Errno::ECONNREFUSED
    return true
  rescue Timeout::Error, Errno::ENETUNREACH, Errno::EHOSTUNREACH
    return false
  end
end

if adress.match re
  puts "Correct IP"
  adress = IPAddr.new adress

  if ping(adress.to_s)
    puts "Scanning ..."
    result = `nc -z #{adress} 1-1023`

    puts "Result : "
    puts result
  else
    puts "host unreachable"
  end
else
  puts "IP Incorrect"
end
