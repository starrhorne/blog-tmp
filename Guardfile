group 'backend' do
  guard 'shell' do
    watch(%r{^(?:_layouts|_posts)/.+\.haml$}){ `bundle exec rake build` }
    watch(%r{^(?:_layouts|_posts)/.+\.markdown$}){ `bundle exec rake build` }
    watch(%r{^(?:_plugins)/.+\.rb$}){ `bundle exec rake build` }
    watch(%r{^(?:sass)/.+\.scss$}){ `compass compile; bundle exec rake build` }
  end
end
