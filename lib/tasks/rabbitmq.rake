namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new
    conn.start

    ch = conn.create_channel

    x = ch.fanout("imageboard.posts")

    queue = ch.queue("dashboard.posts", durable: true)

    queue.bind("imageboard.posts")

    conn.close
  end
end

