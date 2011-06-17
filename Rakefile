require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
desc "Run Rexpl tests"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

require 'yard'
YARD::Rake::YardocTask.new(:docs) do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['-m', 'markdown', '--no-private', '-r', 'Readme.md', '--title', 'Rexpl documentation']
end
task :doc => [:docs]

desc "Generate and open class diagram (needs Graphviz installed)"
task :graph do |t|
 `bundle exec yard graph -d --full --no-private | dot -Tpng -o graph.png && open graph.png`
end

task :default => [:test]
