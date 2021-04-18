import UIKit

public final class LoadingCell: UITableViewCell {
    // MARK: - Properties

    private let content = UIView()
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
        placeholderImageView.tintColor = Color.lightGrey
    }
}

private extension LoadingCell {
    func setupViews() {
        backgroundColor = Color.background
        content.backgroundColor = Color.greyBackground
    }

    func setupHierarchy() {
        addSubview(content)
        content.addSubview(placeholderImageView)
        content.addSubview(longBlock)
        content.addSubview(shortBlock)
    }

    func setupConstraints() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        content.topAnchor.constraint(equalTo: topAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        content.heightAnchor.constraint(equalToConstant: 210).isActive = true

        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 28).isActive = true
        placeholderImageView.topAnchor.constraint(equalTo: content.topAnchor, constant: 30).isActive = true
        placeholderImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        shortBlock.translatesAutoresizingMaskIntoConstraints = false
        shortBlock.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16).isActive = true
        shortBlock.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16).isActive = true
        shortBlock.heightAnchor.constraint(equalToConstant: 16).isActive = true
        shortBlock.widthAnchor.constraint(equalToConstant: 160).isActive =  true

        longBlock.translatesAutoresizingMaskIntoConstraints = false
        longBlock.leftAnchor.constraint(equalTo: shortBlock.leftAnchor).isActive = true
        longBlock.topAnchor.constraint(greaterThanOrEqualTo: placeholderImageView.bottomAnchor).isActive = true
        longBlock.bottomAnchor.constraint(equalTo: shortBlock.topAnchor, constant: -8).isActive = true
        longBlock.heightAnchor.constraint(equalToConstant: 16).isActive = true
        longBlock.widthAnchor.constraint(equalToConstant: 240).isActive =  true
    }
}
