import UIKit

public final class VenueCell: UITableViewCell {
    // MARK: - Properties

    private let content = UIView()
    private let backgroundImageView = UIImageView()
    private let badge = Badge()
    private let name = UILabel()
    private let date = UILabel()
    private let location = UILabel()
    private let time = UILabel()
    private let separator = Separator()
    private let nameDateStackView = UIStackView()
    private let locationTimeStackView = UIStackView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        badge.update(with: model.cost)
        name.text = model.venue
        date.text = model.date
        location.text = model.location
        time.text = model.timeslot

        if backgroundImageView.image == nil {
            backgroundImageView.backgroundColor = Color.greyBackground
        }
    }

    public func update(image: UIImage?) {
        backgroundImageView.image = image
    }
}

private extension VenueCell {
    func setupViews() {
        name.font = Font.medium.size(17)
        name.textColor = .white

        date.font = Font.medium.size(17)
        date.textColor = .white

        name.font = Font.regular.size(17)
        location.textColor = Color.silver

        time.font = Font.regular.size(17)
        time.textColor = Color.silver

        nameDateStackView.axis = .horizontal
        nameDateStackView.spacing = 0
        nameDateStackView.distribution = .fill

        locationTimeStackView.axis = .horizontal
        locationTimeStackView.spacing = 0
        locationTimeStackView.distribution = .fill
    }

    func setupHierarchy() {
        addSubview(content)
        content.addSubview(backgroundImageView)
        content.addSubview(badge)
        nameDateStackView.addArrangedSubview(name)
        nameDateStackView.addArrangedSubview(date)
        content.addSubview(nameDateStackView)
        locationTimeStackView.addArrangedSubview(location)
        locationTimeStackView.addArrangedSubview(time)
        content.addSubview(locationTimeStackView)
        content.addSubview(separator)
    }

    func setupConstraints() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.heightAnchor.constraint(equalToConstant: 210).isActive = true
        content.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        content.topAnchor.constraint(equalTo: topAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leftAnchor.constraint(equalTo: content.leftAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: content.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true

        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 12).isActive = true
        badge.topAnchor.constraint(equalTo: content.topAnchor, constant: 12).isActive = true

        locationTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        locationTimeStackView.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16).isActive = true
        locationTimeStackView.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -16).isActive = true
        locationTimeStackView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -12).isActive = true

        nameDateStackView.translatesAutoresizingMaskIntoConstraints = false
        nameDateStackView.bottomAnchor.constraint(equalTo: locationTimeStackView.topAnchor).isActive = true
        nameDateStackView.leftAnchor.constraint(equalTo: locationTimeStackView.leftAnchor).isActive = true
        nameDateStackView.rightAnchor.constraint(equalTo: locationTimeStackView.rightAnchor).isActive = true
    }
}
