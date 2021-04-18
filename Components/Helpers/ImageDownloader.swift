import SDWebImage
import UIKit

public protocol ImageDownloaderProtocol {
    func download(url: URL?,completion: @escaping (URL?, UIImage?) -> Void)
}

public final class ImageDownloader {
    // MARK: - Properties

    private let downloader: SDWebImageDownloader

    // MARK: - Initialization

    public init(downloader: SDWebImageDownloader = .init()) {
        self.downloader = downloader
    }
}

extension ImageDownloader: ImageDownloaderProtocol {
    public func download(url: URL?, completion: @escaping (URL?, UIImage?) -> Void) {
        downloader.downloadImage(
            with: url,
            options: SDWebImageDownloaderOptions.continueInBackground,
            progress: nil
        ) { (image, _, _, _) in
            completion(url, image)
        }
    }
}
