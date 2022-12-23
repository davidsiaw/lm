# Lm

Logic Minimizer

Minimizes a string such as '0001' and infers the number of bits required. In this case 2, and finds the smallest canonical form.

Use the class `Lm::Minimizer` and give it an output string pattern.

It has two methods `canonical` and `shortest` which will provide the canonical and shortest respectively.

Use the `to_s` method for the output object of type `SumOfProducts` with `:verilog` to request a verilog expression.

If you want you can customize the verilog expression to any variable you like like: `to_s(verilog: 'something')`

See Usage for example.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add lm

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install lm

## Usage

Usage example:

```ruby

    min = Lm::Minimizer.new("1110")
    min.shortest.to_s(verilog: "a") # => ~a[0] | ~a[1]
    min.canonical.to_s(:verilog)    # => ~x[0] & ~x[1] | ~x[0] & x[1] | x[0] & ~x[1]
  end

  it "return canonical" do
    min = Lm::Minimizer.new("1110")
```

## CLI

You can use the CLI to perform rudimentary minimization too.

```
% bundle exec lm 0110
~a[0] & a[1] | a[0] & ~a[1]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/lm/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lm project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lm/blob/main/CODE_OF_CONDUCT.md).
