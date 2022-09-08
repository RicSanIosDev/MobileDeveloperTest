//
//  HomeViewController.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit
import PKHUD

protocol ListDelegate: AnyObject {
    func reloadTable(list: [PostModel])
}

class HomeViewController: UIViewController {
    //MARK: -View components

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return tableView
    }()

    //MARK: - Vars

    var postList: [PostModel] = []
    lazy var presenter = HomePresenter(homeViewDelegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        applyConstraint()
        loadTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    //MARK: - Actions

    func loadTable() {
        tableView.register(UINib.init(nibName: PostCell.identifier, bundle: nil), forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func didPullToRefresh() {
        // Re-fetch data
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.presenter.getPost()
        }
    }
}

//MARK: -HomeViewDelegate

extension HomeViewController: HomeViewDelegate {

    func upload(list: [PostModel]) {
        postList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showActivity() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }

    func stopAndHidenActivity(typeOfHUD: HUDContentType) {
        DispatchQueue.main.async {
            HUD.flash(typeOfHUD, delay: 0.7, completion: {_ in
                HUD.hide()
            })
        }
    }
}

extension HomeViewController: ListDelegate {
    func reloadTable(list: [PostModel]) {
        postList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - Style

extension HomeViewController {
    private func initView() {
        view.backgroundColor = .white
        view.addAutoLayout(subview: tableView)
    }

    private func applyConstraint() {

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Table

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.url = postList[indexPath.row].url
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell

        let post = postList[indexPath.row]
        let create = post.created_at.timeAgoDisplay()
        cell.setupCell(title: post.title, author: post.author, created_at: create)

        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()

            presenter.updateCacheDeleted(post: postList[indexPath.row])
            presenter.updateCachePost(post: postList[indexPath.row])
            postList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.endUpdates()
        }
    }
}
