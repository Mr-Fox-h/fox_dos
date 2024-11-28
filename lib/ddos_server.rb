require 'socket'

server = TCPServer.new 2000 # Server bound to port 2000

loop do
  client = server.accept    # Wait for a client to connect
  client.puts "Connection successful."
  client.write "Hello people!"
  client.send("This is my data!", 0)
  client.close
end

