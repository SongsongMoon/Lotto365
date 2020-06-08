//
//  UsagesViewController.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import WebKit

class UsagesViewController: BaseViewController {

    public var viewModel: UsagesViewModel!
    
    @IBOutlet var webViewContainer: UIView!
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewContainer.addSubview(webView)
        webView.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestWebView()
    }
    
    private func requestWebView() {
        guard let url = URL(string: "") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension UsagesViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
