require 'bundler/setup'
require 'sinatra/base'
require 'rack/rewrite'

# The project root directory
$root = ::File.dirname(__FILE__)

use Rack::Rewrite do
  r301 %r{.*}, 'http://starrhorne.com$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'www.starrhorne.com'
  }
  r301 %r{.*}, 'http://starrhorne.com$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'blog.starrhorne.com'
  }
  r301 %r{.*}, 'http://twitter.com/starrhorne$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'twitter.starrhorne.com'
  }
  r301 %r{.*}, 'http://github.com/starrhorne$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'github.starrhorne.com'
  }
end

class SinatraStaticServer < Sinatra::Base  

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_sinatra_file('404.html') {"Sorry, I cannot find #{request.path}"}
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), '_site',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i  
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
