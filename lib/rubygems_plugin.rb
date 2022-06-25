Gem::CommandManager.instance.register_command :path


class Gem::Commands::PathCommand < Gem::Command

  def initialize
    super "path", "Display gem install path"
  end

  def execute
    _, gem_name, filename = $*
    if gem_name.nil?
      raise Gem::CommandLineError, "Gem name missing"
    end
    gemspec = find_by_name(gem_name)
    path = gemspec.full_gem_path

    if filename.nil?
      puts path
      return
    end

    filepath = Dir["#{path}/**/#{filename}"].first
    if filepath.nil?
      raise Gem::CommandLineError, "Name not found within gem files"
    end
    puts filepath
  rescue Gem::LoadError
    alert_error "gem '#{gem_name}' not found"
    terminate_interaction 1
  end

  def find_by_name(*args)
    if Gem::Specification.respond_to?(:find_by_name)
      Gem::Specification.find_by_name(*args)
    else
      Gem.source_index.find_name(*args).last or raise Gem::LoadError
    end
  end
end
