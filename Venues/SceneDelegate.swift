import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let venuesViewController = VenuesViewController()
        let navigationViewController = NavigationController(rootViewController: venuesViewController)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}
