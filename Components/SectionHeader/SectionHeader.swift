import UIKit

public final class SectionHeader: UIView {
    private let label = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with title: String) {
        label.text = title
    }
}

private extension SectionHeader {
    func setupViews() {
        label.textColor = Color.greyForeground
        label.numberOfLines = 1
    }

    func setupHierarchy() {
        addSubview(label)
    }

    func setupConstraints() {
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 34).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
