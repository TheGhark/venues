import UIKit

final class Badge: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with text: String) {
        label.text = text.uppercased()
    }
}

private extension Badge {
    func setupViews() {
        backgroundColor = Color.translucentBlack72
        layer.cornerRadius = 3
        layer.masksToBounds = true

        label.textColor = .white
        label.font = Font.medium.size(13)
        label.numberOfLines = 1
    }

    func setupHierarchy() {
        addSubview(label)
    }

    func setupConstraints() {
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
    }
}
