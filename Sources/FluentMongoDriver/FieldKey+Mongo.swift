import FluentKit

extension FieldKey {
    func makeMongoKey() -> String {
        switch self {
        case .id:
            return "_id"
        case .string(let name):
            return name
        case .aggregate:
            fatalError("Unsupported field key: \(self).")
        }
    }
}

extension DatabaseQuery.Field {
    func makeMongoPath() throws -> String {
        switch self {
        case .path(let path, _):
            return path.map { $0.makeMongoKey() }.joined(separator: ".")
        case .custom:
            throw FluentMongoError.unsupportedField
        }
    }

    func makeProjectedMongoPath() throws -> String {
        switch self {
        case .path(let path, let schema):
            return "\(schema).\(path.map { $0.makeMongoKey() }.joined(separator: "."))"
        case .custom:
            throw FluentMongoError.unsupportedField
        }
    }
}
