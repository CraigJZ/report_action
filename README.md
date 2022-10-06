# ReportAction

![tests](https://github.com/CraigJZ/report_action/workflows/test_suite/badge.svg)

A collection of tools for structuring and building simple reports, which can be extracted as a structure or as text with html.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'report_action'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install report_action

## Usage

First, initialize a new report structure:
```ruby
my_report = ReportAction::Report.new
```
Then add items to your report using this syntax:
```ruby
my_report.report_item(process, group, message)
```
For example:
```ruby
my_report.report_item('Full Task Report', 'Tasks', 'This is a task')
my_report.report_item('Full Task Report', 'Tasks', 'This is another task')
my_report.report_item('Full Task Report', 'Results', 'This is a result.')
my_report.report_item('User Task Report For Ralph', 'Tasks', 'This is a different task.')
```
Build a report for a single process as text with html headers and paragraphs:
```ruby
my_report.build_report('Full Task Report')
```
which returns:
```html
<h1>Tasks</h1><p>This is a task</p><p>This is another task</p><h1>Results</h1><p>This is a result.</p>
```
List all processes in a report:
```ruby
my_report.list_report_processes
```
Retrieve the full report structure:
```ruby
structure = my_report.retrieve_report_structure
```
See if a report has messages for a given process and group:
```ruby
my_report.has_messages?('Full Task Report', 'Tasks')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, merge changes into main, pull changes locally into then main branch and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CraigJZ/report_action.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
