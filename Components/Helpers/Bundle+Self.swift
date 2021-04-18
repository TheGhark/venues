extension Bundle {
    private final class Components {}

    static var components: Bundle {
        .find(for: Components.self)
    }

    private static func find<T: AnyObject>(for type: T.Type) -> Bundle {
        let currentBundle = Bundle(for: type.self)
        let bundleForStaticLinkage = currentBundle
            .url(forResource: String(describing: type), withExtension: "bundle")
            .flatMap(Bundle.init(url:))
        return bundleForStaticLinkage ?? currentBundle
    }
}
