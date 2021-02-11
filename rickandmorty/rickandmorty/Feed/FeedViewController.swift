//
//  ViewController.swift
//  rickandmorty
//
//  Created by Pavel Kozlov on 11.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    private var viewModel: FeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        viewModel = FeedViewModel(view: self)
        
        loadFeed(page: 1)
    }

    private func loadFeed(page: Int) {
        viewModel.getFeed(by: page) { [weak self] in
            self?.handleResponse(success: $0)
        }
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        viewModel.prev { [weak self] in
            self?.handleResponse(success: $0)
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        viewModel.next {[weak self] in
            self?.handleResponse(success: $0)
        }
    }
    
    private func handleResponse(success: Bool) {
        if success {
            tableView.reloadData()
        } else {
            // alarm future
            print("no success")
        }
    }
}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        (tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterCell)
            .configure(character: viewModel.characters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}


extension ViewController: FeedViewProtocol {
    func showLoader() {
        loader.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        loader.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    func turnPrev(on: Bool) {
        prevButton.isEnabled = on
    }
    
    func turnNext(on: Bool) {
        nextButton.isEnabled = on
    }
    
    func showAlert(with message: String) {
        popupAlert(title: "Warning", message: message)
    }
}
