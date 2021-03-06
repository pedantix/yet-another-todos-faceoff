import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        var qb = Todo.query(on: req).sort(\.createdAt, .descending)
        if let max = try? req.query.get(Int.self, at: "count") {
            qb = qb.range(lower: 0, upper: max)
        }
        return qb.all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }

    /// Returns count of todos
    func count(_ req: Request) -> Future<Int> {
        return Todo.query(on: req).count()
    }
}
