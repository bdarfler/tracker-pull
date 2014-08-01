worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 30)
preload_app true
listen ENV['PORT'], backlog: Integer(ENV['UNICORN_BACKLOG'] || 16)

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end
end
