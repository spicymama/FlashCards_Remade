//
//  RedditPostController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit
import YouTubePlayer
import MobileCoreServices


class PostController {
    static let shared = PostController()
    static var subs: String = ""
    static var height: Double?
    ///fetchPosts will find posts from a selected subreddit, and filter those posts into the media types this app supports (Most gifs, images, and videos)
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        let sub = (subs ) + "/.json"
        let baseURL = URL(string: "https://www.reddit.com")
        guard let finalURL = baseURL?.appendingPathComponent(sub) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                var arrayOfPosts: [Post] = []
                
                for i in thirdLevelObject {
                    let post = i.data
                    
                    if post.over_18 == false {
                        if PostController.mimeTypeForPath(path: post.url).contains("image") || PostController.mimeTypeForPath(path: post.url).contains("mp4") || post.url.contains("youtube") || post.url.contains("youtu.be") {
                            
                            arrayOfPosts.append(post)
                            print(post.url)
                        }
                    }
                }
                completion(.success(arrayOfPosts))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbNail(post: Post, completion: @escaping (Result<UIImage?, PostError>)-> Void) {
        
        guard let thumbNailURL = URL(string: post.url ) else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: thumbNailURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("THUMBNAIL STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let thumbnail = UIImage(data: data)
            else { return completion(.failure(.unableToDecode))}
            
            completion(.success(thumbnail))
        }.resume()
    }
    ///mimeTypeForPath finds the mime type of a given url, helpful for filtering out unsupported media types
    static func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
