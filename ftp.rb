require 'net/ftp'
require 'logger'

# Login to the FTP server
ftp = Net::FTP.new('IP', 'login', 'password')

ftp.chdir('/MyShare/Test')
files = ftp.list

puts "list out files in root directory:"
puts files
puts ftp.getdir

files = ftp.nlst("*.txt")
puts "After nlst"
puts files

#optionally exclude falsely matched files
exclude = /\.old|temp/

#exclude files with 'old' or 'temp' in the name
files = files.reject{ |e| exclude.match e } #remove files matching the exclude regex

files.each do |file|
	puts 'each'
	puts file
end
ftp.close
