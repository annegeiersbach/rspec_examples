require 'colorize'
require 'rspec/core/formatters/base_text_formatter'

# More options shown here:
# https://rspec.info/documentation/3.9/rspec-core/RSpec/Core/Formatters/BaseTextFormatter.html
# the core methods to override are actually in Protocol:
# https://rspec.info/documentation/3.9/rspec-core/RSpec/Core/Formatters/Protocol.html
class CustomFormat < ::RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self,
    :example_passed, :example_failed, :example_pending

  def initialize output
    @output = output
  end

  def example_passed notification #ExampleNotification
    @output << "#{notification.example.location} ".green
  end

  def example_failed notification #FailedExampleNotification
    @output << "#{notification.example.location} ".red
  end

  def example_pending notification
    @output << "#{notification.example.location} ".yellow
  end
end
