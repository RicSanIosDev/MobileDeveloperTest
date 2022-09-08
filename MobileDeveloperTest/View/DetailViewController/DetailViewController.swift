//
//  DetailViewController.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit
import WebKit
import PKHUD

final class DetailViewController: UIViewController, WKUIDelegate {

    //MARK: -View components
    var webView = WKWebView()


    //MARK: - Vars

    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        applyConstraint()
        self.webView.clipsToBounds = true
    }

    func configView() {
        guard let urls = URL(string: url) else { return  }
        webView.load(URLRequest(url: urls))
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsLinkPreview = true
    }

    @objc private func dissmissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: - Style

extension DetailViewController {
    private func initView() {
        view.backgroundColor = .white
        view.addAutoLayout(subview: webView)
    }

    private func applyConstraint() {

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        DispatchQueue.main.async {
            HUD.flash(.success, delay: 0.4, completion: {_ in
                HUD.hide()
            })
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            HUD.flash(.error, delay: 0.4, completion: {_ in
                HUD.hide()
            })
        }
    }
}
