import Components
import UIKit

final class VenuesViewController: UIViewController {
    // MARK: - Properties

    private let tabBar = TabBar()
    private let tableView = UITableView()
    private let viewModel: VenuesViewModel

    // MARK: - Initialization

    init(viewModel: VenuesViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupHierarchy()
        setupConstraints()
        bindViewModel()
        viewModel.didChange(state: .didLoad)
        title = Localization.App.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.didChange(state: .willAppear)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didChange(state: .didAppear)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.didChange(state: .willDisappear)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didChange(state: .didDisappear)
    }
}

private extension VenuesViewController {
    // MARK: - Private
    
    func setupViews() {
        view.backgroundColor = Color.foreground

        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(LoadingCell.self, forCellReuseIdentifier: .init(describing: LoadingCell.self))
        tableView.register(VenueCell.self, forCellReuseIdentifier: .init(describing: VenueCell.self))
        tableView.register(WarningCell.self, forCellReuseIdentifier: .init(describing: WarningCell.self))
    }
    
    func setupHierarchy() {
        view.addSubview(tabBar)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tabBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func bindViewModel() {
    }
}

extension VenuesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.model(at: indexPath)

        if
            let model = model as? LoadingCell.Model,
            let cell = tableView.dequeueReusableCell(
                withIdentifier: .init(describing: LoadingCell.self),
                for: indexPath
                ) as? LoadingCell
            {
            cell.update(with: model)
            return cell
        }
        if
            let model = model as? VenueCell.Model,
            let cell = tableView.dequeueReusableCell(
                withIdentifier: .init(describing: VenueCell.self),
                for: indexPath
                ) as? VenueCell
            {
            cell.update(with: model)
            return cell
        }
        if
            let model = model as? WarningCell.Model,
            let cell = tableView.dequeueReusableCell(
                withIdentifier: .init(describing: WarningCell.self),
                for: indexPath
                ) as? WarningCell
            {
            cell.update(with: model)
            return cell
        }
        assertionFailure("A custom cell must be dequeued")
        return .init()
    }
}

extension VenuesViewController: UITableViewDelegate {
    
}

extension VenuesViewController: VenuesViewModelDelegate {
    func reload() {
        tabBar.update(with: viewModel.tabBarModel)
        tableView.reloadData()
    }

    func select(tab: TabBarButton.Model?) {
        tabBar.update(with: viewModel.tabBarModel)
    }
}
