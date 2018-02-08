# Fxrates

This gem keeps data on Foreign Exchange rates over the previous 90 days from the Europiean Central Bank (ECB).

The data is updated daily at 15:00.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fxrates'

or

gem 'fxrates', :git => 'https://github.com/stuart32/fxrates'
```

And then execute:

    $ bundle


## Usage

Add the cron rake task to your cronfile:

    $ whenever -w

## Method List

getRates() - Stores fx data from ECB to db/rates.json

getRate(currency,date) -  Returns the exchange rate for the curency given in @currency from the data given in @data.

getRatesFromDate(date) - Returns the FX data for the date given in @date.

getCurrencyFromDate(date) - Returns each curreny three letter refrence for a given date with 'EUR' added.

at(date,base,counter) - Returns the exchange rate from @base to @counter on @date.

calcTotal(date,amount,base,counter) - Converts @amount in @base into its eqivelent in @counter on @date. 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stuart32 /fxrates.
# fxrates
