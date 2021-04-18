import UIKit

public final class Button: UIView {
    // MARK: - Properties

    private let button = UIButton()
    private var model: Model?

    // MARK: - Initialization

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

    // MARK: - Public

    public func update(with model: Model) {
        button.setTitle(model.title, for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
}

// MARK: - Private

private extension Button {
    func setupViews() {
        layer.cornerRadius = 8
        layer.masksToBounds = true

        button.backgroundColor = Color.orange
    }

    func setupHierarchy() {
        addSubview(button)
    }

    func setupConstraints() {
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @objc func tapped() {
        model?.action?()
    }
}
