//
//  View.swift
//  todo-app
//
//  Created by Gabriel on 15/12/24.
//

import UIKit
import Foundation

class HomeView: UIView {
    let labelView: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextView: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.layer.borderColor = UIColor.black.cgColor
        input.layer.borderWidth = 2.0
        input.layer.cornerRadius = 8.0
        input.clipsToBounds = true
        input.placeholder = "Clique aqui para digitar..."
        let paddingLeft = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: input.frame.height))
        input.leftView = paddingLeft
        input.leftViewMode = .always
        return input
    }()
    
    let buttonView: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar nova tarefa", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor   // Cor da sombra
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        scroll.showsHorizontalScrollIndicator = true
        return scroll
    }()
    
    let containerTaskView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI () {
        addSubview(labelView)
        addSubview(inputTextView)
        addSubview(buttonView)
        addSubview(scrollView)
        scrollView.addSubview(containerTaskView)
        
        setupConstrains()
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            inputTextView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 4),
            inputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            inputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            inputTextView.heightAnchor.constraint(equalToConstant: 50),
            
            buttonView.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 8),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            
            containerTaskView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerTaskView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            containerTaskView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),            containerTaskView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    @objc func addNewTask() {
        if inputTextView.text != "" {
            let taskView = TaskView()

            taskView.translatesAutoresizingMaskIntoConstraints = false
            taskView.taskLabel.text = inputTextView.text!
            taskView.removeButton.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
            
            containerTaskView.addArrangedSubview(taskView)
            
            NSLayoutConstraint.activate([
                taskView.leadingAnchor.constraint(equalTo: containerTaskView.leadingAnchor),
                taskView.trailingAnchor.constraint(equalTo: containerTaskView.trailingAnchor),
            ])
        }
    }
    
    @objc func removeTask(_ sender: UIButton) {
        if let taskView = sender.superview?.superview {
            containerTaskView.removeArrangedSubview(taskView)
            taskView.removeConstraints(taskView.constraints)
            taskView.removeFromSuperview()
        } else {
            print("TaskView não encontrado!")
        }
    }
    
}
