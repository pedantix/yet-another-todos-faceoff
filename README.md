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

### Locally Hosted
Vapor - http://localhost:8080/todos
Rails - http://localhost:3000/todos


#### Comparison 1
`wrk  -d 30s http://localhost:8080/todos\?count\=1`
`wrk  -d 30s http://localhost:3000/todos\?count\=1`

#### Comparison 2
`wrk  -d 30s http://localhost:8080/todos\?count\=10`
`wrk  -d 30s http://localhost:3000/todos\?count\=10`

#### Comparison 3
`wrk  -d 30s http://localhost:8080/todos\?count\=100`
`wrk  -d 30s http://localhost:3000/todos\?count\=100`

#### Comparison 4
`wrk  -d 30s http://localhost:8080/todos\?count\=1000`
`wrk  -d 30s http://localhost:3000/todos\?count\=1000`

#### Comparison 5
`wrk  -d 30s http://localhost:8080/todos\?count\=10000`
`wrk  -d 30s http://localhost:3000/todos\?count\=10000`

# Talk Slides
https://docs.google.com/presentation/d/e/2PACX-1vRGBaelirYsYpaakVdama8bKr41rk1cdj_ve3RdLXC7DyKsXsLgRZku8mfeBHomProu5xKFjeuMdANZ/pub?start=false&loop=false&delayms=3000
