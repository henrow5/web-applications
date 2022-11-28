# POST /sort-names Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


HTTP Method: POST
Path: /sort-names
body paramenters: string of comma separated names


## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

when body param `names` is `Joe,Alice,Zoe,Julia,Kieran`
```html
Alice,Joe,Julia,Kieran,Zoe
```

when body param `names` is `Ben,Adrian,Chris`
```html
Adrian,Ben,Chris
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
POST /sort-names

# With body parameters:
names=Joe,Alice,Zoe,Julia,Kieran

# Expected response (sorted list of names):
Alice,Joe,Julia,Kieran,Zoe
```

```
# Request:
POST /sort-names

# With body parameters:
names=Ben,Adrian,Chris

# Expected response (sorted list of names):
Adrian,Ben,Chris
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /sort-names" do
    it "returns a string of 5 sorted names" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end

    it "returns a string of 3 sorted names" do
      response = post("/sort-names", names: "Ben,Adrian,Chris")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Adrian,Ben,Chris")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.