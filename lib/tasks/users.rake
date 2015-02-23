namespace :users do
  desc "TODO"
  task load: :environment do
    puts 'begin'
    f = File.open("/tmp/users.dat", 'r+')
    f.each_line do |line|
      ll = line.chomp.split('::')
      User.create(id: ll.first, twitter_id: ll.last)
      print '.'
    end
    f.close
    puts 'done'
  end

  desc "TODO"
  task update: :environment do
    puts 'begin'
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "7OVMLDUsY3EqGSMjyFZdiw"
      config.consumer_secret     = "E2F0xnt6AXfi3I8tPxbN6jNXs8VM1NHaFZ0HQBgawA"
      config.access_token        = "16249193-EfPkaK9W0NCbavggr1FzJRQ2gHxQIUOFxu79Y2OH0"
      config.access_token_secret = "Jvg9M4kNgyyHxIa0tS9CPbGN4ms7YjMvp0EVkstCuls"
    end
    
    User.all.each do |u|
      next unless u.name.empty?
      begin
        uu = client.user(u.twitter_id.to_i)
        u.set(name: uu.name,
              image_url: uu.profile_image_url.to_s,
              handle: uu.handle)
        print '.'
      rescue Exception => e 
        puts e
      end
    end
    puts 'done'
  end
end
