//
//  FeedViewModel.swift
//  rickandmorty
//
//  Created by Pavel Kozlov on 11.02.2021.
//

import UIKit

typealias BoolCompletion = ((Bool) -> Void)

protocol FeedViewProtocol: class {
    func showLoader()
    func hideLoader()
    
    func turnPrev(on: Bool)
    func turnNext(on: Bool)
}

class FeedViewModel {
    private weak var view: FeedViewProtocol?
    
    private var feed: Feed?
    
    private var pages: Int {
        feed?.info.pages ?? 0
    }
    private var currentPage: Int = 1
    
    var characters: [Character] {
        feed?.results ?? []
    }
    
    private var previousPage: String?
    private var nextPage: String?
    
    init(view: FeedViewProtocol?) {
        self.view = view
    }
    
    func prev(completion: @escaping BoolCompletion) {
        guard currentPage > 1 else { completion(false); return }
        currentPage -= 1
        getFeed(by: currentPage, completion: completion)
        updateButtons()
    }
    
    func next(completion: @escaping BoolCompletion) {
        guard currentPage < pages else { completion(false); return }
        currentPage += 1
        getFeed(by: currentPage, completion: completion)
        updateButtons()
    }
    
    private func updateButtons() {
        view?.turnPrev(on: currentPage > 1)
        view?.turnNext(on: currentPage < pages)
    }
    
    func getFeed(by page: Int = 1, completion: @escaping BoolCompletion) { // swift result in future
        view?.showLoader()
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (feed: Feed?, response, error) in
            if let error = error {
                debugPrint(error)
                DispatchQueue.main.async {
                    self.view?.hideLoader()
                    completion(false)
                }
                return
            }

            guard let feed = feed else {
                debugPrint(NSError(domain: "not found", code: -1, userInfo: nil))
                DispatchQueue.main.async {
                    self.view?.hideLoader()
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.feed = feed
                self.view?.hideLoader()
                completion(true)
            }
        })
        task.resume()
    }
    
}

