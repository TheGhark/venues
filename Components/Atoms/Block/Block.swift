import UIKit

final class Block: UIView {
    private let view = UIView()

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
}

private extension Block {
    func setupViews() {
        backgroundColor = .clear
        layer.cornerRadius = 3
        layer.masksToBounds = true

        view.backgroundColor = Color.lightGrey
    }

    func setupHierarchy() {
        addSubview(view)
    }

    func setupConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
