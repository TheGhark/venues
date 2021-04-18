import Components

protocol VenuesViewModelDelegate: class {
    func reload()
}

final class VenuesViewModel {
    enum Section {
        case warning(type: WarningCell.Model)
        case loading(models: [LoadingCell.Model])
        case venues(venues: [VenueCell.Model])
    }

    // MARK: - Properties

    weak var delegate: VenuesViewModelDelegate?
    private var sections: [Section] = []
    private let venuesRepository: VenuesRepositoryProtocol
    private let modelFactory: VenuesModelFactoryProtocol

    // MARK: - Initialization

    init(
        venuesRepository: VenuesRepositoryProtocol = VenuesRepository(),
        modelFactory: VenuesModelFactoryProtocol = VenuesModelFactory()
    ) {
        self.venuesRepository = venuesRepository
        self.modelFactory = modelFactory
    }
}

private extension VenuesViewModel {
    func createSections(with venues: [Venue]) {
        defer {
            delegate?.reload()
        }
        if venues.isEmpty {
            sections = [
                .warning(
                    type: modelFactory.warningModel(type: .empty) { [weak self] in
                        self?.fetch()
                    }
                ),
                .loading(
                    models:
                        [
                            modelFactory.loadingModel(),
                            modelFactory.loadingModel()
                        ]
                )
            ]
        } else {
            sections = [
                .venues(venues: venues.map(modelFactory.venueModel(with:)))
            ]
        }
    }

    func handle(error: Error) {
        let warningType: WarningCell.Model.WarningType
        if case VenuesApiService.Error.noConnection = error {
            warningType = .noConnection
        } else {
            warningType = .error
        }
        sections = [
            .warning(
                type: modelFactory.warningModel(type: warningType) { [weak self] in
                    self?.fetch()
                }
            ),
            .loading(
                models:
                    [
                        modelFactory.loadingModel(),
                        modelFactory.loadingModel()
                    ]
            )
        ]
        delegate?.reload()
    }

    func fetch() {
        venuesRepository.fetchVenues { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(venues):
                self.createSections(with: venues)
            case let .failure(error):
                self.handle(error: error)
            }
        }
    }
}

// MARK: - TableViewDataSourceProtocol
extension VenuesViewModel: TableViewDataSourceProtocol {
    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfItems(at section: Int) -> Int {
        let section = sections[section]

        switch section {
        case .warning:
            return 1
        case let .loading(models):
            return models.count
        case let .venues(models):
            return models.count
        }
    }
    
    func model(at indexPath: IndexPath) -> ComponentModel {
        let section = sections[indexPath.section]

        switch section {
        case let .warning(model):
            return model
        case let .loading(models):
            return models[indexPath.row]
        case let .venues(models):
            return models[indexPath.row]
        }
    }
}

// MARK: - LifecycleStateObservable
extension VenuesViewModel: LifecycleStateObservable {
    func didChange(state: LifecycleState) {
        switch state {
        case .didLoad:
            sections = [
                .loading(
                    models: [
                        modelFactory.loadingModel(),
                        modelFactory.loadingModel(),
                        modelFactory.loadingModel()
                    ]
                )
            ]
            delegate?.reload()
        case .willAppear:
            fetch()
        case .didAppear, .willDisappear, .didDisappear:
            break
        }
    }
}
