Gem::Specification.new do |s|
  s.name        = "fox dos"
  s.version     = "0.1.0"
  s.summary     = "This is a simple dos and ddos tools, made with Ruby language."
  s.description = "A simple hello world gem"
  s.authors     = "Meisam Heidari"
  s.email       = "Meisam Heidari"
  s.files       = ["lib/fox_dos.rb"]
  s.homepage    = "https://github.com/Mr-Fox-h/fox_dos"
  s.add_runtime_dependency 'concurrent-ruby', '~> 1.3', '>= 1.3.4'
  s.add_runtime_dependency 'optparse', '~> 0.6.0'
  s.license     = "MIT"
end
