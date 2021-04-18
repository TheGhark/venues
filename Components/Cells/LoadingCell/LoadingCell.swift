import UIKit

public final class LoadingCell: UITableViewCell {
    // MARK: - Properties

    private let placeholderImageView = UIImageView()
    private let longBlock = Block()
    private let shortBlock = Block()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    public func update(with model: Model) {
        placeholderImageView.image = model.icon.image
    }
}

private extension LoadingCell {
    func setupViews() {
        backgroundColor = Color.greyForeground
    }

    func setupHierarchy() {
        addSubview(placeholderImageView)
        addSubview(longBlock)
        addSubview(shortBlock)
    }

    func setupConstraints() {
        placeholderImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        placeholderImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        placeholderImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        shortBlock.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        shortBlock.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
        shortBlock.heightAnchor.constraint(equalToConstant: 16).isActive = true
        shortBlock.widthAnchor.constraint(equalToConstant: 160).isActive =  true

        longBlock.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        longBlock.bottomAnchor.constraint(equalTo: shortBlock.topAnchor, constant: 8).isActive = true
        longBlock.heightAnchor.constraint(equalToConstant: 16).isActive = true
        longBlock.widthAnchor.constraint(equalToConstant: 240).isActive =  true
    }
}
