import UIKit

public final class TabBarButton: UIView {
    private let button = UIButton()
    private let indicator = Indicator()
    private var model: Model?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select() {
        button.setTitleColor(Color.orange, for: .normal)
        indicator.isHidden = false
    }

    func deselect() {
        button.setTitleColor(Color.greyForeground, for: .normal)
        indicator.isHidden = true
    }

    func update(with model: Model) {
        self.model = model
        button.setTitle(model.title.uppercased(), for: .normal)
        if model.selected {
            select()
        } else {
            deselect()
        }

        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
}

private extension TabBarButton {
    func setupViews() {
        button.setTitleColor(Color.greyForeground, for: .normal)
        button.titleLabel?.font = Font.medium.size(13)
    }

    func setupHierarchy() {
        addSubview(button)
        addSubview(indicator)
    }

    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: indicator.topAnchor).isActive = true

        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        indicator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        indicator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    @objc func tapped() {
        guard let model = model else { return }
        model.action(model)
    }
}
