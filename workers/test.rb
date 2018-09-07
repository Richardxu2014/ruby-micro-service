require 'sneakers'
require 'json'
require 'user'

  
  # 接收 queue 为 test 的请求
class Test
  include Sneakers::Worker
  from_queue :test

  def work(message)
    puts "RECEIVED: #{message}"
    option = JSON.parse(message)
    p 'option： 查询user '
    p User[1]
    
    $logger.info("User[1]: #{ User[1].name }")

    if err["type"] == "error"
      $redis.incr "processor:#{err["error"]}"
      
    end
    ack!
  end
end
