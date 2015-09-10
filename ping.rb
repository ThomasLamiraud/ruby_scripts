require 'logger'
require 'ipaddr'
require 'timeout'
require 'socket'


puts "Ping"
puts "Find used IP on your network"

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

ips = []
puts "Scanning the network"
for i in 1..20
  puts "Check : 192.168.1.#{i}"
  if ping("192.168.1.#{i}")
    puts "192.168.1.#{i} is used"
    ips.push("192.168.1.#{i}")
  end
end

puts "============================================"
puts "Those ip seems to be used on your network : "
puts ips
