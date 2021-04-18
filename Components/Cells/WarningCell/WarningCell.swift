import UIKit

public final class WarningCell: UITableViewCell {
    // MARK: - Properties

    private var model: Model?

    private let content = UIView()
    private let stackView = UIStackView()
    private let icon = UIImageView()
    private let iconContainer = UIView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let button = Button()

    // MARK: - Computed Properties
    
    public var type: Model.WarningType? {
        model?.type
    }

    // MARK: - Initialization

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
        icon.image = model.type.image
        icon.tintColor = Color.grey

        title.text = model.title
        subtitle.text = model.subtitle

        if let buttonModel = model.buttonModel {
            button.isHidden = false
            button.update(with: buttonModel)
        } else {
            button.isHidden = true
        }
    }
}

private extension WarningCell {
    func setupViews() {
        backgroundColor = Color.background

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill

        title.textColor = Color.greyForeground
        title.font = Font.medium.size(17)
        title.numberOfLines = 0
        title.textAlignment = .center

        subtitle.textColor = Color.greyForeground
        subtitle.font = Font.regular.size(16)
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
    }

    func setupHierarchy() {
        iconContainer.addSubview(icon)
        stackView.addArrangedSubview(iconContainer)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(button)
        content.addSubview(stackView)
        addSubview(content)
    }

    func setupConstraints() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        content.topAnchor.constraint(equalTo: topAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24).isActive = true
        stackView.topAnchor.constraint(equalTo: content.topAnchor, constant: 48).isActive = true
        stackView.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -24).isActive = true
        stackView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -56).isActive = true

        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 39).isActive = true
        icon.topAnchor.constraint(equalTo: iconContainer.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -20).isActive = true
        icon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor).isActive = true
    }
}
