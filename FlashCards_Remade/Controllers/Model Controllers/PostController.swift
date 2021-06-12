//
//  RedditPostController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit


class PostController {
    static let shared = PostController()
    static var subs: String = ""
    static var height: Double?
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
       
        let sub = (subs ) + "/.json"
        let baseURL = URL(string: "https://www.reddit.com/")
        
        guard let finalURL = baseURL?.appendingPathComponent(sub) else {return completion(.failure(.invalidURL))}
            print(finalURL)
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
        
        guard let thumbNailURL = URL(string: post.url ?? "www.reddit.com") else {return completion(.failure(.invalidURL))}
       
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




/*
 
 r/AdviceAnimals
 r/aww
 r/blessedimages
 r/cats
 r/dankmemes
 r/dogpictures
 r/funny
 r/LifeProTips
 r/me_irl
 r/memes
 r/mildlyinteresting
 r/NatureIsFuckingLit
 r/pics
 r/ProgrammerHumor
 r/Showerthoughts
 
 */
