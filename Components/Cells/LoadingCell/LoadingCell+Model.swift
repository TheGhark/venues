public extension LoadingCell {
    struct Model: ComponentModel {
        let icon: Icon
    
        public init(icon: Icon) {
            self.icon = icon
        }
    }
}
