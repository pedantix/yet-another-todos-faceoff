# TODOS Faceoff

### Two Apps

* Vapor API
* Rails API

### One DB

* PostgreSQL

### Sample Data

The sample data was generated with the following command:
`swift run Run generate_todos -c 9999 -d true`

## Comparing performance

### Heroku
Vapor - http://localhost:8080/todos
Rails - http://localhost:3000/todos


#### Comparison 1
`wrk  -d 10s http://localhost:8080/todos\?count\=1`
`wrk  -d 10s http://localhost:3000/todos\?count\=1`

#### Comparison 2
`wrk  -d 10s http://localhost:8080/todos\?count\=10`
`wrk  -d 10s http://localhost:3000/todos\?count\=10`

#### Comparison 3
`wrk  -d 10s http://localhost:8080/todos\?count\=100`
`wrk  -d 10s http://localhost:3000/todos\?count\=100`

#### Comparison 4
`wrk  -d 10s http://localhost:8080/todos\?count\=1000`
`wrk  -d 10s http://localhost:3000/todos\?count\=1000`

#### Comparison 5
`wrk  -d 10s http://localhost:8080/todos\?count\=10000`
`wrk  -d 10s http://localhost:3000/todos\?count\=10000`
