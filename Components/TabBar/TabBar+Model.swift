public extension TabBar {
    struct Model {
        public let buttons: [TabBarButton.Model]

        public init(buttons: [TabBarButton.Model]) {
            self.buttons = buttons
        }
    }
}
