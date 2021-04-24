# frozen_string_literal: true

require 'puppeteer'

launch_options = {
  executable_path: ENV['PUPPETEER_EXECUTABLE_PATH'],
  args: ['--no-sandbox']
}
Puppeteer.launch(**launch_options) do |browser|
  page = browser.pages.first || browser.new_page
  page.goto('https://takagi.blog/')
  articles = page.query_selector_all('main article').take(5)
  articles.each do |article|
    date = article.query_selector('header small')['innerText'].json_value
    title = article.query_selector('a')['innerText'].json_value
    puts "#{date}: #{title}"
  end
end
