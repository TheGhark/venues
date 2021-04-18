import UIKit

public final class TabBar: UIView {
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(with model: Model) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        model.buttons.forEach { model in
            let button = TabBarButton()
            button.update(with: model)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
    }
}

private extension TabBar {
    func setupViews() {
        stackView.backgroundColor = Color.background
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
    }

    func setupHierarchy() {
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
