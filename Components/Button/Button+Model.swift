public extension Button {
    struct Model: Equatable {
        public static func ==(lhs: Button.Model, rhs: Button.Model) -> Bool {
            lhs.title == rhs.title
        }

        let title: String
        let action: (() -> Void)?

        public init(title: String, action: (() -> Void)?) {
            self.title = title
            self.action = action
        }
    }
}
