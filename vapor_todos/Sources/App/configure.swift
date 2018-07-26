import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    try configureDatabase(&services)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .psql)
    services.register(migrations)

    configureCommands(&services)
}

private func configureCommands(_ services: inout Services) {
    /// Create a `CommandConfig` with default commands.
    var commandConfig = CommandConfig.default()
    /// Add the `GenerateTodos`.
    commandConfig.use(GenerateTodos(), as: "generate_todos")
    /// Register this `CommandConfig` to services.
    services.register(commandConfig)
}

private func configureDatabase(_ services: inout Services) throws {
    let databaseConfig: PostgreSQLDatabaseConfig
    if let databaseUrl = ProcessInfo.processInfo.environment["DATABASE_URL"],
        let config = PostgreSQLDatabaseConfig(url: databaseUrl) {
        databaseConfig = config
    } else if let databaseUrl = ProcessInfo.processInfo.environment["DB_POSTGRESQL"],
        let config = PostgreSQLDatabaseConfig(url: databaseUrl) {
        databaseConfig = config
    } else {
        let databaseHostname = ProcessInfo.processInfo.environment["DATABASE_HOSTNAME"] ?? "localhost"
        let databasePort = Int(ProcessInfo.processInfo.environment["DATABASE_PORT"] ?? "") ??  5432
        let databaseUsername = ProcessInfo.processInfo.environment["DATABASE_USERNAME"] ??  "shaunhubbard"

        let databasePassword = ProcessInfo.processInfo.environment["DATABASE_PASSWORD"]
        let databaseName = ProcessInfo.processInfo.environment["DATABASE_NAME"] ??  "todos_db"
        databaseConfig = PostgreSQLDatabaseConfig(hostname: databaseHostname,
                                                  port: databasePort,
                                                  username: databaseUsername,
                                                  database: databaseName,
                                                  password: databasePassword)
    }

    let database = PostgreSQLDatabase(config: databaseConfig)

    var databasesConfig = DatabasesConfig()
    databasesConfig.add(database: database,
                        as: .psql)

    //databasesConfig.enableLogging(on: .psql)
    services.register(databasesConfig)
}
