import UIKit

final class Separator: UIView {
    private let view = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Separator {
    private func setupView() {
        backgroundColor = .clear
        view.backgroundColor = Color.greyBackground
    }

    func setupHierarchy() {
        addSubview(view)
    }

    func setupConstraints() {
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
