import UIKit

final class Indicator: UIView {
    let view = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        .init(width: 24, height: 2)
    }
}

private extension Indicator {
    func setupViews() {
        backgroundColor = .clear
        view.backgroundColor = Color.orange
    }

    func setupHierarchy() {
        addSubview(view)
    }

    func setupConstraints() {
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
