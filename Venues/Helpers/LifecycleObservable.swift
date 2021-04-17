enum LifecycleState: CaseIterable {
    case didLoad
    case willAppear
    case didAppear
    case willDisappear
    case didDisappear
}

protocol LifecycleStateObservable {
    func didChange(state: LifecycleState)
}
