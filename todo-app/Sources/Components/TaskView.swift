//
//  TaskView.swift
//  todo-app
//
//  Created by Gabriel on 16/12/24.
//

import Foundation
import UIKit

class TaskView: UIView {
    let taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remover", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        taskStackView.addArrangedSubview(checkButton)
        taskStackView.addArrangedSubview(taskLabel)
        taskStackView.addArrangedSubview(removeButton)
        addSubview(taskStackView)
        setupConstrains()
        
        checkButton.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.heightAnchor.constraint(equalToConstant: 50),
            taskStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            taskStackView.topAnchor.constraint(equalTo: taskStackView.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            taskStackView.heightAnchor.constraint(equalToConstant: 50),
            taskLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor)
        ])
    }
    
    @objc func toggleCheck() {
        let attributedString = NSMutableAttributedString(string: taskLabel.text!)
        if checkButton.currentImage == UIImage(systemName: "checkmark.circle") {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            attributedString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: taskLabel.text!.count)
            )
            taskLabel.attributedText = attributedString
        } else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            attributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: taskLabel.text!.count))
            taskLabel.attributedText = attributedString
        }
    }
    
    @objc func removeTask() {
        self.removeFromSuperview()
    }
    
}
