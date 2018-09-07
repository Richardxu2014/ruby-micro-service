require 'bundler/setup'

model_path = File.expand_path '../../models', __FILE__
worker_path = File.expand_path '../../workers', __FILE__
$LOAD_PATH.unshift(model_path,worker_path)

# ./bin/test env=prodution
ARGV.each do |arg|
  p arg
  ENV['ENVIRONMENT'] = %w(production development test).detect {|e| e =~ /^#{arg.split('=')[1]}/} if arg.include? "env"
end

ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'
p ENVIRONMENT

require 'settingslogic'
class Settings < Settingslogic
    source File.expand_path('../application.yml', __FILE__)
    namespace ENVIRONMENT
end    

p Settings.amqp_url

require 'sequel'
require 'mysql2'
require 'redis'
require 'logger'

DB = Sequel.connect(
  adapter: :mysql2, 
  host: Settings.mysql.host, 
  port: Settings.mysql.port,
  user: Settings.mysql.user, 
  password: Settings.mysql.password, 
  database: Settings.mysql.database, 
  max_connections: 10, 
  logger: Logger.new('logs/db.log', 'daily'),  # 数据库访问日志
  encoding: 'utf8', 
)

$redis = Redis.new(
	host: Settings.redis.host, 
	port: Settings.redis.port, 
	auth_pass: Settings.redis.auth_pass, 
)

$logger = Logger.new('logs/service.log', 'daily') # 微服务日志
$logger.level = Logger::DEBUG
$logger.datetime_format = '%Y-%m-%d %H:%M:%S'
$logger.info("ENV= #{ENVIRONMENT} server start .....")