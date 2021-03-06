require 'rake'
require 'rake/clean'

namespace(:dependencies) do
  namespace(:rbreadline) do
    package = RubyInstaller::PureReadline
    directory package.target
    CLEAN.include(package.target)

    # Put files for the :download task
    package.files.each do |f|
      file_source = "#{package.url}/#{f}"
      file_target = "downloads/#{f}"
      download file_target => file_source

      # depend on downloads directory
      file file_target => "downloads"

      # download task need these files as pre-requisites
      task :download => file_target
    end

    # Prepare the :sandbox, it requires the :download task
    task :extract => [:extract_utils, :download, package.target] do
      # grab the files from the download task
      files = Rake::Task['dependencies:rbreadline:download'].prerequisites

      files.each { |f|
        extract(File.join(RubyInstaller::ROOT, f), package.target)
      }
    end

    # FIXME: remove duplication
    task :install18 => [package.target] do
      interpreter = RubyInstaller::Ruby18
      new_ruby = File.join(RubyInstaller::ROOT, interpreter.install_target, "bin").gsub(File::SEPARATOR, File::ALT_SEPARATOR)
      ENV['PATH'] = "#{new_ruby};#{ENV['PATH']}"
      ENV.delete("RUBYOPT")
      cd package.target do
        sh "ruby setup.rb #{(package.configure_options || []).join(' ')}"
      end
    end

    task :install19 => [package.target] do
      interpreter = RubyInstaller::Ruby19
      new_ruby = File.join(RubyInstaller::ROOT, interpreter.install_target, "bin").gsub(File::SEPARATOR, File::ALT_SEPARATOR)
      ENV['PATH'] = "#{new_ruby};#{ENV['PATH']}"
      ENV.delete("RUBYOPT")
      cd package.target do
        sh "ruby setup.rb #{(package.configure_options || []).join(' ')}"
      end
    end

    task :install20 => [package.target] do
      interpreter = RubyInstaller::Ruby20
      new_ruby = File.join(RubyInstaller::ROOT, interpreter.install_target, "bin").gsub(File::SEPARATOR, File::ALT_SEPARATOR)
      ENV['PATH'] = "#{new_ruby};#{ENV['PATH']}"
      ENV.delete("RUBYOPT")
      cd package.target do
        sh "ruby setup.rb #{(package.configure_options || []).join(' ')}"
      end
    end

    task :install21 => [package.target] do
      interpreter = RubyInstaller::Ruby21
      new_ruby = File.join(RubyInstaller::ROOT, interpreter.install_target, "bin").gsub(File::SEPARATOR, File::ALT_SEPARATOR)
      ENV['PATH'] = "#{new_ruby};#{ENV['PATH']}"
      ENV.delete("RUBYOPT")
      cd package.target do
        sh "ruby setup.rb #{(package.configure_options || []).join(' ')}"
      end
    end
  end
end

task :rbreadline => [
  'dependencies:rbreadline:download',
  'dependencies:rbreadline:extract'
]
