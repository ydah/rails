# frozen_string_literal: true

require "qunit/selenium/test_runner"

if ARGV[1]
  driver = ::Selenium::WebDriver.for(:remote, url: ARGV[1], desired_capabilities: :chrome)
else
  require "webdrivers"

  driver_options = Selenium::WebDriver::Chrome::Options.new
  driver_options.add_argument("--headless")
  driver_options.add_argument("--disable-gpu")
  driver_options.add_argument("--no-sandbox")

  driver = ::Selenium::WebDriver.for(:chrome, options: driver_options)
end

result = QUnit::Selenium::TestRunner.new(driver).open(ARGV[0], timeout: 60)
driver.quit

puts "Time: #{result.duration} seconds, Total: #{result.assertions[:total]}, Passed: #{result.assertions[:passed]}, Failed: #{result.assertions[:failed]}"
exit(result.tests[:failed] > 0 ? 1 : 0)
