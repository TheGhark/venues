import UIKit

final class Button: UIView {
    private let button = UIButton()
    private var model: Model?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: Model) {
        button.setTitle(model.title, for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
}

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

    @objc func  tapped() {
        model?.action()
    }
}
