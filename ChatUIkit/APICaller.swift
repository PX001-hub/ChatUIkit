//
//  APICaller.swift
//  ChatUIkit
//
//  Created by P Z on 01/03/2023.
//

import OpenAISwift
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
       public func getResponse(input: String,
completion: @escaping (Result<String, Error>) -> Void) {
           client?.sendCompletion(with: input, completionHandler: { result in
               switch result {
               case .success(let model):
                   print(String(describing: model.choices))
                   let output = model.choices.first?.text ?? ""
                   completion(.success(output))
               case .failure(let error):
                   completion(.failure(error))
               }
           })
}

    
}
