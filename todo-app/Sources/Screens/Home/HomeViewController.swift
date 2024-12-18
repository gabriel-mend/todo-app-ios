//
//  ViewController.swift
//  todo-app
//
//  Created by Gabriel on 15/12/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let contentView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        contentView.backgroundColor = .white
        setupConstrains()
        
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }

}

