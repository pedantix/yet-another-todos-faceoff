import FluentPostgreSQL
import Command

struct GenerateTodos: Command {
    let deleteKey = "delete"
    let countKey = "count"
    /// See `Command`
    var arguments: [CommandArgument] {
        return []
    }

    /// See `Command`
    var options: [CommandOption] {
        return [
            .value(name: countKey, short: "c", default: "1000", help: ["Number of Todos to Create"]),
            .value(name: deleteKey, short: "d", default: "false", help: ["Delete Todos"]),
        ]
    }

    /// See `Command`
    var help: [String] {
        return ["Generates TODOs from the command line using fakser."]
    }

    /// See `Command`.
    func run(using context: CommandContext) throws -> Future<Void> {
        /// Options
        guard let count = try Int(context.requireOption(countKey)),
            let shouldDelete = Bool(try context.requireOption(deleteKey)) else { fatalError("Invalid Options") }



        return context.container.withPooledConnection(to: .psql) { connection -> EventLoopFuture<Void> in
            if shouldDelete {
                context.console.print("Clearing TODOS!")
                return self.deleteTodos(on: connection).flatMap {
                    context.console.print("TODOS Cleared! Create \(count) Todos in their place")
                    return self.createTodos(count, connection: connection).then {
                       return self.finished(context: context)
                    }
                }
            } else {
                context.console.print("Creating \(count) TODOS at Random" )
                return self.createTodos(count, connection: connection).then {
                    return self.finished(context: context)
                }
            }
        }
    }

    private func createTodos(_ count: Int, connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        let title = "Todo \(count)"
        if (count > 1) {
            return Todo(title: title).save(on: connection).flatMap { _ in
                return self.createTodos(count - 1, connection: connection)
            }
        } else {
            return Todo(title: title).save(on: connection).map(to: Void.self) { _ in }
        }
    }


    private func deleteTodos(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Todo.query(on: connection).delete()
    }

    private func finished(context: CommandContext) -> EventLoopFuture<Void> {
        context.console.print("Closing Context")
        return .done(on: context.container)
    }
}
