Gem::CommandManager.instance.register_command :path


class Gem::Commands::PathCommand < Gem::Command

  def initialize
    super "path", "Display gem install path"
  end

  def execute
    name = get_one_gem_name
    gemspec = find_by_name(name)
    puts gemspec.full_gem_path
  rescue Gem::LoadError
    alert_error "gem '#{name}' not found"
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
