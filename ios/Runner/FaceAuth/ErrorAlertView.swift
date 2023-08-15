//
//  ErrorAlertView.swift
//  Runner
//
//  Created by Tim Guo on 2023/8/15.
//

import UIKit

class ErrorAlertView: UIView {

    static func showAlert(with message: String, cancelAction: @escaping () -> Void, confirmAction: @escaping () -> Void) {
        let alert = ErrorAlertView()
        alert.messageLabel.text = message
        alert.cancelAction = cancelAction
        alert.okAction = confirmAction
        alert.show()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds);
        addSubview(container)
        container.addSubview(iconView)
        container.addSubview(messageLabel)
        container.addSubview(cancelBtn)
        container.addSubview(okBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var container = {
        let view = UIView(frame: CGRect(x: 20, y: (self.bounds.height - 215) * 0.5, width: UIScreen.main.bounds.width - 40, height: 215))
        view.alpha = 0;
        view.transform = .init(scaleX: 1.1, y: 1.1)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var iconView = {
        let imgView = UIImageView(frame: CGRect(x: (container.bounds.size.width - 66) / 2, y: 20, width: 66, height: 66))
        imgView.image = UIImage(named: "error_icon");
        return imgView
    }()
    
    private lazy var messageLabel = {
        let lb = UILabel(frame: CGRect(x: 20, y: CGRectGetMaxY(iconView.frame), width: container.bounds.width - 40, height: 25))
        lb.textColor = UIColor(red: 99.0 / 255.0, green: 99.0 / 255.0, blue: 99.0 / 255.0, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var cancelBtn = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = UIColor(red: 230.0 / 255.0, green: 150.0 / 255.0, blue: 101.0 / 255.0, alpha: 1)
        btn.frame = CGRect(x: 20, y: CGRectGetMaxY(messageLabel.frame) + 16, width: (container.bounds.width - 55) * 0.5, height: 52)
        btn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        btn.layer.cornerRadius = 12.0
        return btn
    }()
    
    private lazy var okBtn = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Ok", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = UIColor(red: 224.0 / 255.0, green: 101.0 / 255.0, blue: 44.0 / 255.0, alpha: 1)
        btn.frame = CGRect(x: CGRectGetMaxX(cancelBtn.frame) + 15.0, y: cancelBtn.frame.origin.y, width: cancelBtn.bounds.size.width, height: 52)
        btn.layer.cornerRadius = 12.0
        btn.addTarget(self, action: #selector(okBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private var cancelAction: (() -> Void)?
    private var okAction: (() -> Void)?
    
    @objc func cancelBtnClicked() {
        cancelAction?()
        dismiss()
    }
    
    @objc func okBtnClicked() {
        okAction?()
        dismiss()
    }
    
    private func show() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.last?.addSubview(self)
        UIView.animate(withDuration: 0.25) {
            self.container.alpha = 1
            self.container.transform = .identity
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.container.alpha = 0
            self.container.transform = .init(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}
