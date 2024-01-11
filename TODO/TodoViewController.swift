//
//  ViewController.swift
//  TODO
//
//  Created by Youngho Kwon on 12/15/23.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?

    var todoList: [Todo] = [] {
        didSet {
            saveTodoList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodoList()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.reloadData()
    }

    @IBAction func didTapAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "할 일 추가",
                                                 message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "할 일을 입력하세요"
        }
        let addAction = UIAlertAction(title: "추가",
                                      style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                let newItem = Todo(id: (todoList.last?.id ?? -1) + 1,
                                   title: title,
                                   isCompleted: false)
                todoList.append(newItem)
                self.tableView?.insertRows(at: [IndexPath(row: todoList.count-1, section: 0)], with: .automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let updateAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            self?.showEditAlert(at: indexPath.row)
            }

        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.deleteTodoItem(at: indexPath.row)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionSheet.addAction(updateAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
        }
    }
extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        cell.setTask(todoList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// UserDefaults 확장 - TodoList 저장 및 로드
extension TodoViewController {
    private func saveTodoList() {
        let data = try? PropertyListEncoder().encode(todoList)
        UserDefaults.standard.set(data, forKey: "todoListKey")
    }

    private func loadTodoList() {
        if let data = UserDefaults.standard.value(forKey: "todoListKey") as? Data {
            if let savedList = try? PropertyListDecoder().decode([Todo].self, from: data) {
                todoList = savedList
            }
        }
    }
    
    private func deleteTodoItem(at index: Int) {
        todoList.remove(at: index)
        tableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }

    private func showEditAlert(at index: Int) {
        let alertController = UIAlertController(title: "할 일 수정",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.todoList[index].title
        }
        let saveAction = UIAlertAction(title: "저장",
                                       style: .default) { [weak self] _ in
            guard let self, let title = alertController.textFields?.first?.text, !title.isEmpty else { return }
            self.updateTodoItem(at: index, withTitle: title)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func updateTodoItem(at index: Int, withTitle title: String) {
        todoList[index].title = title
        tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
