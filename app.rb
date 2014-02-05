require 'sinatra'

get '/' do
  contents = <<-HTML
    <p> This is a list of items.</p>
    <a href="/items">List of items</a>
  HTML

  erb contents
end