//
//  ToDoListTableViewController.swift
//  ToDoListik
//
//  Created by Андрей Тихонов on 22/03/2019.
//  Copyright © 2019 Андрей Тихонов. All rights reserved.
//

import UIKit

protocol NoteListProtocol: class {
    var noteList: [Note] { get set }
}

class ToDoListTableViewController: UITableViewController, NoteListProtocol {

    var noteList: [Note] = []
    private var delegate: NoteListProtocol?
    private var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        let note = noteList[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = "\(note.getCount())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createToDoListTableViewController(with: noteList[indexPath.row], delegate: self, index: indexPath.row)
    }

    private func createToDoListTableViewController(with note: Note?, delegate: NoteListProtocol, index: Int) {
        guard let toDoListTableViewController = UIStoryboard.main?.instantiateViewController(withIdentifier: "toDoListTableViewController") as? ToDoListTableViewController else { return }
        if let note = note {
            toDoListTableViewController.noteList = note.notes
            self.delegate = delegate
            self.index = index
        }
        navigationController?.show(toDoListTableViewController, sender: nil)
    }

    @IBAction func addActionPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Новая запись", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { textField in
            textField.placeholder = "Название записи"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: UIAlertAction.Style.default) { [weak self] (alert) in
            guard let title = alertController.textFields?[0].text else { return }
            let note = Note(title: title)
            if let delegate = self?.delegate, let index = self?.index {
                delegate.noteList[index] = note
            }
            self?.noteList.append(note)
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default) { (alert) in }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension UIStoryboard {
    static var main: UIStoryboard? {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}
