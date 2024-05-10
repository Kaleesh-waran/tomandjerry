//
//  MyTableViewCell.swift
//  Tom & Jerry
//
//  Created by Kaleeshwaran P on 21/11/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let containerView: UIView = UIView()
    let cellImageView: UIImageView = UIImageView()
    let cellLabel: UILabel = UILabel()

    //MARK: - Life Cycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setUpContainView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpContainView()
        setUpCellImageView()
        setUpCellLable()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init\(coder) has not been implemented")
    }
    
    private func setUpContainView() {
        
        contentView.addSubview(containerView)
        
        self.selectionStyle = .none
        backgroundColor = .clear
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemGray4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    private func setUpCellImageView() {
        
        containerView.addSubview(cellImageView)
        
        cellImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            cellImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cellImageView.trailingAnchor.constraint(equalTo:containerView.trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
        
    }
    
    private func setUpCellLable() {
        
        cellImageView.addSubview(cellLabel)
        
        cellLabel.layer.shadowColor = UIColor.black.cgColor
        cellLabel.layer.shadowRadius = 3.0
        cellLabel.layer.shadowOpacity = 1.0
        cellLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        cellLabel.layer.masksToBounds = false
        cellLabel.textColor = UIColor.white
        cellLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            cellLabel.topAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: cellImageView.trailingAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: 20),
            cellLabel.bottomAnchor.constraint(equalTo: cellImageView.bottomAnchor)
        ])
        
    }
}

extension MyTableViewCell {
    
    func loader() -> UIActivityIndicatorView {
        
        let loaderIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 150, y: 50, width: 50, height: 50))
        
        loaderIndicator.hidesWhenStopped = true
        loaderIndicator.color = .white
        loaderIndicator.style = UIActivityIndicatorView.Style.medium
        loaderIndicator.startAnimating()
        
        containerView.addSubview(loaderIndicator)
        
        return loaderIndicator
    }
    
    func stopLoader(view: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            
            for i in self.containerView.subviews {
                
                if i == view {
                    
                    view.removeFromSuperview()
                }
            }
        }
    }
}
