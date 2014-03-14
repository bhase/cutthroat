# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
 watch('Gemfile')
 watch(/^.+\.gemspec/)
end

guard 'rake', :task => 'alltests', :run_on_start => false do
  watch(%r{(lib/.+\.rb)})
end

guard 'rake', :task => 'unit' do
  watch(%r{(test/.+\.rb)})
end

guard 'cucumber', :cli => '--profile guard' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  }
end

