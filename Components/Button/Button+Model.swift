extension Button {
    public struct Model {
        let title: String
        let action: (() -> Void)?

        public init(title: String, action: (() -> Void)?) {
            self.title = title
            self.action = action
        }
    }
}
