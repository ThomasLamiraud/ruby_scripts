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

for i in 1..255
  puts "scanning..."
  if ping("192.168.1.#{i}")
    puts "192.168.1.#{i} is used"
  end
end
