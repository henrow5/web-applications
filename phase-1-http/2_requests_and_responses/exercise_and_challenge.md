## Exercise

Use `curl` to send the following HTTP request:
  * Host: `https://jsonplaceholder.typicode.com`
  * Method: `GET`
  * Path: `/todos/12`

You should get the following response body:
```
{
  "userId": 1,
  "id": 12,
  "title": "ipsa repellendus fugit nisi",
  "completed": true
}
```

Solution:

```bash
curl https://jsonplaceholder.typicode.com/todos/12
```

<!-- OMITTED -->

## Challenge

Use `curl` to send the following HTTP request:
  * Host: `https://jsonplaceholder.typicode.com`
  * Method: `POST`
  * Path: `/todos`

You should get the following response body:
```
{
  "id": 201
}
```

Solution:

```bash
curl -X POST https://jsonplaceholder.typicode.com/todos
```
