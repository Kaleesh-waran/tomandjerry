//
//  ViewController.swift
//  Tom & Jerry
//
//  Created by Kaleeshwaran P on 17/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    let tableView: UITableView = UITableView()
    var count: Int = {
        
        return videoList.count
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupTableView()
        setupNavBar()
        ApiCall.shared.apiCall(vc: self)
    }
    
    //MARK: - Methods
    
    private func setupNavBar() {
        
        title = "Tom & Jerry video"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

//MARK: - Extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return count 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? MyTableViewCell {
            
            TableViewViewModel.shared.setValueForCell(cell: cell, indexPath: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        TableViewViewModel.shared.playVideo(vc: self, indexPath: indexPath)
    }
    
}

extension ViewController {
    
    func loader() -> UIAlertController {
        
        let alert: UIAlertController = UIAlertController(title: nil, message: "please wait...", preferredStyle: .alert)
        let loaderIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
        loaderIndicator.hidesWhenStopped = true
        loaderIndicator.style = UIActivityIndicatorView.Style.large
        loaderIndicator.startAnimating()
        
        alert.view.addSubview(loaderIndicator)
        self.parent?.present(alert, animated: true)
        
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        
        DispatchQueue.main.async {
            
            loader.dismiss(animated: true)
        }
    }
}
