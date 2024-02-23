//
//  HTTP+Publisher.swift
//  SwiftUIPractice
//
//  Created by 디해 on 2023/03/20.
//

import Foundation
import Combine

extension URLSession {
    // 추상화란? 같은 부분을 묶고, 달라지는 부분을 분리한다.
    func makeURLPublisher<Response: Decodable>(_ urlRequest: URLRequest, decodedType: Response.Type) -> AnyPublisher<Response, Never> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest.url!)
            .tryMap { data, response in
                print(data)
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
}


//extension URLSession {
//    func makeURLPublisher<Response: Decodable>(_ urlRequest: URLRequest, decodedType: Response.Type) -> AnyPublisher<Response, Never> {
//        return URLSession.shared.dataTaskPublisher(for: urlRequest.url!)
//            .tryMap { data, response in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                    print(String(data: data, encoding: .utf8) ?? "Unable to convert data to text")
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: Response.self, decoder: JSONDecoder())
//            .catch { error -> AnyPublisher<Response, Never> in
//                print("Request failed with error: \(error)")
//                return Empty().eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//}






