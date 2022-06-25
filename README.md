# Rubygems 'path' command plugin

Adds the "gem path" command to rubygems that displays a gem install path:
```sh
gem install rubygems-path
gem path rubygems-path
```

If an optional name is specified, path to the corresponding directory or file
is displayed:
```sh
gem path rubygems-path rubygems_plugin.rb
```

## License

Copyright (c) Grigory Petrov. MIT License.
