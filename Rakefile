#!/usr/bin/env rake
require "bundler/gem_tasks"

### Specs 

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

### Gem Packaging and Release

require File.expand_path("../lib/presta_shop/version", __FILE__)
namespace :package do
    NAME = "presta_shop"
    VER  = PrestaShop.version

    task :build do
        sh "gem build #{NAME}.gemspec"
    end

    task :publish do 
        sh "gem push ./#{NAME}-#{VER}.gem"
    end
end

### Gem misc 

require File.expand_path "../lib/presta_shop/resources", __FILE__
require "active_support/core_ext"
require "erb"
namespace :presta do
    namespace :models do
        def model_template
%{module PrestaShop
    class <%= @class_name %> < Model

        resource :<%= @resource %>

    end
end}
        end

        desc "Builds resource's model classes - aka I'm to lazy"
        task :build do
            models_path = File.expand_path("../lib/presta_shop/models", __FILE__) 

            # remove old models
            FileUtils.rmdir models_path, :verbose => true

            # create directory structure
            models_subpaths = PrestaShop::RESOURCES.select { |r| 
                r.include? "/" # => r.classify.include? "::" 
            }.map { |r| 
                File.join(models_path, r)
            }

            models_subpaths.each do |p|
                FileUtils.mkdir_p p
            end

            # create models
            erb = ERB.new model_template
            PrestaShop::RESOURCES.each do |r|
                next if r.include? "/"

                File.open(File.join(models_path, "#{r.singularize}.rb"), "w+") do |file|
                    @resource = r
                    @class_name = @resource.classify
                    file.write erb.result(binding)
                end
            end

            # create required file
            File.open(File.expand_path("../lib/presta_shop/models.rb", __FILE__), "w+") do |file|
                PrestaShop::RESOURCES.each do |r|
                    next if r.include? "/"

                    file.write "require \"presta_shop/models/#{r.singularize}\" \n"
                end
            end
        end 
    end
end

### Utils/Misc

namespace :utils do
    task :expand_tabs do 
        Dir[File.expand_path("../**/*.rb", __FILE__)].each do |p|
            content = File.read p
            modified_content = content.gsub /\t/, '    '
            File.write p, modified_content 
        end
    end
end