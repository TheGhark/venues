import UIKit

public protocol ImageDownloaderProtocol {
    var url: URL? { get }
    func download(completion: @escaping (UIImage?) -> Void)
}

final class ImageDownloader {
    // MARK: - Properties

    let url: URL?
    private let session: URLSession

    // MARK: - Initialization

    init(
        session: URLSession = .shared,
        url: URL?
        ) {
        self.session = session
        self.url = url
    }
}

extension ImageDownloader: ImageDownloaderProtocol {
    func download(completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        session.downloadTask(with: request) { (path, response, error) in
            if error != nil {
                completion(nil)
            } else if let path = path {
                let image = UIImage(contentsOfFile: path.absoluteString)
                completion(image)
            }
        }
    }
}
