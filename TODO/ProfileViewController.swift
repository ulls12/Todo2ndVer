//
//  ProfileViewController.swift
//  TODO
//
//  Created by t2023-m0044 on 2/1/24.
//

import UIKit

//스토리보드 구성 없이 code-based 구성
class ProfileViewController: UIViewController {

    var userName: String?
    var userAge: Int?
    
    //이름이 나오는 label 설정
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //나이가 나오는 label 설정
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        // 데이터 바인딩
        updateUI()
        
        // 닫기 버튼 추가
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // View에 데이터 바인딩
    func updateUI() {
        if let name = userName {
            nameLabel.text = "Name: \(name)"
            view.addSubview(nameLabel)
            NSLayoutConstraint.activate([
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
            ])
        }
        if let age = userAge {
            ageLabel.text = "Age: \(age)"
            view.addSubview(ageLabel)
            NSLayoutConstraint.activate([
                ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
            ])
        }
    }
    
    // 닫기 버튼 액션
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }


}
