//
//  ViewController.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: [OwnerItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.title = "totalCount:\(self.viewModel.capacity)"
                self.infoTableView.reloadData()
            }
        }
    }
    
    //MARK: - Components
    let infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
        tableView.estimatedRowHeight = 300
        return tableView
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        layoutTableView()
    }
    
    //MARK: - Functions
    private func getUserInfo() {
        WebService.shared.getUserInfo { result in
            switch result {
            case .success(let info):
                print(info)
                self.viewModel = info.data.items
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func layoutTableView() {
        view.addSubview(infoTableView)
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
        let vm = self.viewModel[indexPath.row]
        cell.viewModel = UserInfoViewModel(imageUrl: vm.user.imageURL, name: vm.user.nickName.rawValue, tags: vm.tags)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
