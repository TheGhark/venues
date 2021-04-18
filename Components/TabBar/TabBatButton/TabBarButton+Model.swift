public extension TabBarButton {
    struct Model: Equatable {
        public static func ==(lhs: TabBarButton.Model, rhs: TabBarButton.Model) -> Bool {
            lhs.title == rhs.title
        }

        public let title: String
        public var selected: Bool
        let action: (Model) -> Void

        public init(
            title: String,
            selected: Bool,
            action: @escaping ((Model) -> Void)
        ) {
            self.title = title
            self.selected = selected
            self.action = action
        }
    }
}
