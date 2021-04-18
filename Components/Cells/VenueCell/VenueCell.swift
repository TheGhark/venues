import UIKit

public final class VenueCell: UITableViewCell {
    // MARK: - Properties

    private let backgroundImageView = UIImageView()
    private let badge = Badge()
    private let name = UILabel()
    private let date = UILabel()
    private let location = UILabel()
    private let time = UILabel()
    private let separator = Separator()
    private let nameDateStackView = UIStackView()
    private let locationTimeStackView = UIStackView()

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
        badge.update(with: model.cost)
        name.text = model.venue
        date.text = model.date
        location.text = model.location
        time.text = model.timeslot

        if backgroundImageView.image == nil {
            backgroundImageView.backgroundColor = Color.greyBackground
        }

        model.imageDownloader.download { [weak self] image in
            self?.backgroundImageView.image = image
        }
    }
}

private extension VenueCell {
    func setupViews() {
        name.font =  Font.medium.size(17)
        name.textColor = Color.foreground

        date.font =  Font.medium.size(17)
        date.textColor = Color.foreground

        name.font =  Font.regular.size(17)
        location.textColor = Color.lightGrey

        time.font =  Font.regular.size(17)
        time.textColor = Color.lightGrey

        nameDateStackView.axis = .horizontal
        nameDateStackView.spacing = 0
        nameDateStackView.distribution = .fillEqually

        locationTimeStackView.axis = .horizontal
        locationTimeStackView.spacing = 0
        locationTimeStackView.distribution = .fillEqually
    }

    func setupHierarchy() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(badge)
        nameDateStackView.addArrangedSubview(name)
        nameDateStackView.addArrangedSubview(date)
        backgroundImageView.addSubview(nameDateStackView)
        locationTimeStackView.addArrangedSubview(location)
        locationTimeStackView.addArrangedSubview(time)
        backgroundImageView.addSubview(locationTimeStackView)
        backgroundImageView.addSubview(separator)
    }

    func setupConstraints() {
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 12).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        badge.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        badge.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        locationTimeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        locationTimeStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        locationTimeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12).isActive = true
        locationTimeStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        nameDateStackView.bottomAnchor.constraint(equalTo: locationTimeStackView.topAnchor).isActive = true
        nameDateStackView.leftAnchor.constraint(equalTo: locationTimeStackView.leftAnchor).isActive = true
        nameDateStackView.rightAnchor.constraint(equalTo: locationTimeStackView.rightAnchor).isActive = true
        nameDateStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
