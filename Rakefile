require 'bundler'
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber, 'Run features that should pass') do |t|
  exempt_tags = ['--tags ~@wip']
  t.cucumber_opts = "--color #{exempt_tags.join(' ')} --strict"
end

require 'rake/clean'

task test: :cucumber
task default: :test

desc 'Build HTML documentation'
task :doc do
  sh 'bundle exec yard'
end
