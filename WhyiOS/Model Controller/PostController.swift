//
//  PostController.swift
//  WhyiOS
//
//  Created by John Tate on 9/6/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    
    // This makes it so we can only have one instance
    private init() {}
 
    private let baseURL = URL(string: "https://whydidyouchooseios.firebaseio.com/")
 
    // Source of Truth
    var posts: [Post] = []
    
    // 1) Know what we are completing with
    // 2) URLSession - reverse engineer
    // 3) ^Build the URL
    // 4) Handle the data
    
    // CREATE
    func putPost(reason: String, name: String, cohort: String, completion: @escaping (Bool) -> Void) {
    
        guard let url = baseURL else {
            fatalError("Bad baseURL")
        }
        
        let post = Post(name: name, cohort: cohort, reason: reason)
        
        let builtUrl = url.appendingPathComponent("reasons").appendingPathComponent(post.uuid.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: builtUrl)
        request.httpMethod = "PUT"
        
        // TODO: - Come Back
        request.httpBody = post.jsonData
        
        // With request - you need to define the HTTP protocol
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error with dataTask \(error.localizedDescription)")
                completion(false); return
            }

            if let data = data, let response = String(data: data, encoding: .utf8) {
                
                // Human readable version of our data in our console
                print(response); completion(false)
            }
            
            self.posts.append(post)
            completion(true)
            
        }.resume()
    }
    
<<<<<<< HEAD
    func fetchPost(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let url = baseURL else {
            fatalError("Bad Base URL")
        }
        
        let requestUrl = url.appendingPathComponent("reasons").appendingPathExtension("json")
        
        
        // dataTask with URL has HTTP 'GET' build within it
        URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            
            if let error = error {
                print("Error fetching \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let data = data else { completion(false); return }
            
            do {
                // VERY SIMILAR TO JSONDecoder
                guard let postDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: [String:String]] else {
                    print("cannot de-serialize")
                    completion(false); return }
                // here we use the failable initializer
                // value is our Object and ket is the UUID
                let posts = postDictionary.compactMap{Post(dictionary: $0.value, identifier: $0.key)}
                self.posts = posts
                completion(true)
            } catch let error {
                print("Error fetching post data \(error) \(error.localizedDescription)")
                completion(false); return
            }
        }.resume()
=======
    func putPost(name: String, reason: String, completion: @escaping (_ success: Bool) -> Void){
        let post = Post(name: name, reason: reason)
        guard let url = PostController.baseURL else {fatalError("bad baseURL")}
        let builtURL = url.appendingPathComponent(post.uuid).appendingPathExtension("json")
        var request = URLRequest(url: builtURL)
        
        let jsonEncoder = JSONEncoder()
        do{
            let data = try jsonEncoder.encode(post)
            request.httpMethod = "PUT"
            request.httpBody = data
        }catch let error {
            print("🤮 Error putting with data task: \(error) \(error.localizedDescription)")
            completion(false); return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("🤮 Error Fetching with data task: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            //for me
            guard let data = data,
                let responseString = String(data: data, encoding: .utf8) else {completion(false); return}
            print(responseString)
            
            //connect the local array to the instances in the cloud or wherever
            PostController.shared.posts.append(post)
            completion(true)
            }.resume()
>>>>>>> 7bafa3e16fd1cfdb86a13f94ce13d74455ecf491
    }
    
//    func postReason(name: String, reason: String, completion: @escaping (_ success: Bool) -> Void) {
//
//        guard let url = PostController.baseURL?.appendingPathComponent("reasons").appendingPathExtension("json") else {
//            completion(false); return
//        }
//        // Print URL for PUT request
//        print(url)
//
//         let requestURL = url.appendingPathComponent("reasons").appendingPathExtension("json")
//
//        let post = Post(name: name, reason: reason)
//
//        var request = URLRequest(url: requestURL)
//
//        let jsonEncoder = JSONEncoder()
//        do {
//            let data = try jsonEncoder.encode(post)
//            request.httpMethod = "PUT"
//            request.httpBody = data
//        } catch let error {
//            print("Error with JSONEncoder for post: \(error) \(error.localizedDescription)")
//        }
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let error = error {
//                print("Error with PUT request: \(error) \(error.localizedDescription)")
//            }
//
//            guard let data = data, let responseString = String(data: data, encoding: .utf8) else { completion(false); return }
//            print(responseString)
//
//            self.posts.append(post)
//            completion(true)
//
//        }.resume()
//    }
}
