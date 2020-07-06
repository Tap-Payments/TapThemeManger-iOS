//
//  FileDownloader.swift
//  TapThemeManagerSwiftDemo
//
//  Created by Kareem Ahmed on 7/5/20.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation

//protocol FileDownloaderDelegate: class {
//    func didFinishDownloading(at path: String)
//}

internal class FileDownloader: NSObject {
    
    public var completion: ((Data) -> ())?
    /// This is file url used to download
    private var fileUrl: String
    
    /// This is the session used to download the file content
    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "tap.theme.download.background")
      return URLSession(configuration: configuration,
                        delegate: self,
                        delegateQueue: nil)
    }()
    
    private var downloadingTask: URLSessionDownloadTask?
//    weak var delegate: FileDownloaderDelegate?
    // MARK: Init
    init(fileUrl: String) {
        self.fileUrl = fileUrl
    }
    
    // MARK: Downloading Process
    /// This function start the file downloading process
    func startDownloading() {
        guard let url = URL(string: fileUrl) else { return }
        downloadingTask = downloadSession.downloadTask(with: url)
        downloadingTask?.resume()
    }
    
    func cancelDownloading() {
        downloadingTask?.cancel()
    }
    
    fileprivate func saveDownloadedFile(at destinationUrl: URL, from location: URL) {
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationUrl)
        
        do {
            try fileManager.copyItem(at: location, to: destinationUrl)
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
}

extension FileDownloader: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        guard let sourceUrl = downloadTask.originalRequest?.url else { return }
        let destinationUrl = localFilePath(for: sourceUrl)
        print("destinationURL: \(destinationUrl.absoluteString)")
        
        saveDownloadedFile(at: destinationUrl, from: location)
        do {
            let fileContent = try Data(contentsOf: destinationUrl)
            completion?(fileContent)
        } catch {
            print("error loading ontent of file")
        }
        
    }
    
    func localFilePath(for url: URL) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullName = url.lastPathComponent
        return documentsPath.appendingPathComponent(fullName)
    }
}
