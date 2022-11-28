## Exercise One

Use Postman to send a `GET` request to the URL `https://postman-echo.com/get`.

In the "Query params" section, set a query parameter with key `title` and value `'Welcome'`. Then send the request.

You should get the following JSON response, and the status code should be `200 OK`:

```json
{
    "args": {
        "title": "Welcome",
    },
    "headers": {
        // (omitted).
    },
    "url": "https://postman-echo.com/get?title=Welcome"
}
```

_You'll note that Postman automatically added the parameters at the end of the URL, using a syntax such as `?title=Welcome` — this is the way query parameters are sent in `GET` requests, inside the URL itself._

[Solution video](https://www.youtube.com/watch?v=zwU6SpTwuxY&t=420s)

## Exercise Two

Use Postman to send a `POST` request to the URL `https://postman-echo.com/post`.In the "Body" tab below the URL field, select the option "form-data", and set a parameter with key `title` and value `'Welcome'`. Then send the request.

You should get the following JSON response, and the status code should be `200 OK`:

```json
{
    "args": {},
    "data": {},
    "files": {},
    "form": {
        "title": "Welcome"
    },
    "headers": {
        // (omitted).
    },
    "json": null,
    "url": "https://postman-echo.com/post"
}
```

[Solution video](https://www.youtube.com/watch?v=zwU6SpTwuxY&t=530s)