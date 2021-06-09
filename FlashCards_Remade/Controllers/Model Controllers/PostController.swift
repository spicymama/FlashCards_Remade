//
//  RedditPostController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit


class PostController {
    static let shared = PostController()
    var subredditList: [String] = []
    
    static func fetchSubreddits(completion: @escaping (Result<[String], PostError>)-> Void) {
        let baseURL = URL(string: "https://www.reddit.com/subreddits/popular/.json")
        
        guard let finalURL = baseURL else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(SubredditTopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                

                for i in thirdLevelObject {
                    let subreddit = i.data.display_name_prefixed
                
                    PostController.shared.subredditList.append(subreddit)
                    print(subreddit)
                }
                completion(.success(PostController.shared.subredditList))
                
            } catch {
                completion(.failure(.thrownError(error)))
                
            }
        }.resume()
    }
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        let baseURL = URL(string: "https://www.reddit.com/subreddits/popular/.json")
        
        guard let finalURL = baseURL else {return completion(.failure(.invalidURL))}
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
                    arrayOfPosts.append(post)
                    
                }
                completion(.success(arrayOfPosts))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    static func fetchThumbNail(post: Post, completion: @escaping (Result<UIImage, PostError>)-> Void) {
        
        guard let thumbNailURL = URL(string: post.thumbnail) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: thumbNailURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("THUMBNAIL STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnail = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
        
            completion(.success(thumbnail))
            
        }.resume()
        
    }
    
   
}

