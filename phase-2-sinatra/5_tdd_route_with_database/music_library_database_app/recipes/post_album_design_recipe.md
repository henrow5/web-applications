# POST /album Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._
# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


Expected response (200 OK) 
Method: POST 
Path: /albums
body parameters: 
title=Voyage
release_year=2022
artist_id=2

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._
when body params 
title=Voyage
release_year=2022
artist_id=2
```html
Expected response (200 OK) 
""
```

```html

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /albums
# With body parameters
body parameters: 
title=Voyage
release_year=2022
artist_id=2

# Expected response:
Response for 200 OK
""
```

```

```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it '200 OK and creates a new album' do
      # Assuming the post with id 1 exists.
      response = post('/albums', title: 'voyager', release_year: '2022', artist_id: '2')

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('voyager')
    end

    it 'returns 404 Not Found' do
      response = post('/posts?id=276278')

      expect(response.status).to eq(404)
      
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---


