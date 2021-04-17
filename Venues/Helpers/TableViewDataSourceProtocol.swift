import Components
import UIKit

protocol TableViewDataSourceProtocol {
    var numberOfSections: Int { get }
    func numberOfItems(at section: Int) -> Int
    func model(at indexPath: IndexPath) -> ComponentModel
}
