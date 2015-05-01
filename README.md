# Ignorefile
Compile a set of ignore statements from files and code.

## Usage

```ruby
reqire 'ignorefile'

cookbook_files = Dir.glob('**/{*,.*}')
ignore = IgnoreFile.new('.gitignore', 'chefignore', ['.git/*'])

ignore.apply!(cookbook_files)
```

## Thanks
This gem is based upon Seth Vargo's [buff-ignore](https://github.com/sethvargo/buff-ignore).
