import UIKit
import PinLayout


final class SignUpViewController: UIViewController {
    
    /// MARK: - placeholder for  textField (username)
    private lazy var labelForUsername: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "Имя пользователя"
        label.textColor = .textFieldPlaceholderColor
        label.font = .textFieldPlaceholderFont
        
        return label
    }()
    
    
    /// MARK: - placeholder for  textField (username)
    private lazy var labelForEmail: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "Email"
        label.textColor = .textFieldPlaceholderColor
        label.font = .textFieldPlaceholderFont
        
        return label
    }()
    
    
    /// MARK: - placeholder for  textField (password)
    private lazy var labelForPassword: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "Пароль"
        label.textColor = .textFieldPlaceholderColor
        label.font = .textFieldPlaceholderFont
        
        return label
    }()
    
    
    /// MARK: - array views for textField's underline
    private lazy var underlines: [UIView] = {
        var arrayUnderlines: [UIView] = []
        
        (0 ..< Constants.ContainerTextFields.countTextFields).forEach { _ in
            let underline = UIView()
            underline.backgroundColor = .black
            arrayUnderlines.append(underline)
        }
        
        return arrayUnderlines
    }()
    
    
    /// MARK: - textField for login
    private lazy var textFieldUsername: UITextField = {
        let textField = UITextField()
        
        textField.font = .textFieldInput
        textField.textColor = .textFieldInputColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.contentVerticalAlignment = .bottom
        
        return textField
    }()
    
    
    /// MARK: - textField for email
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField()
        
        textField.font = .textFieldInput
        textField.textColor = .textFieldInputColor
        textField.keyboardType = .emailAddress
        textField.borderStyle = UITextField.BorderStyle.none
        textField.contentVerticalAlignment = .bottom
        
        return textField
    }()
    
    
    /// MARK: - textField for password
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        
        textField.font = .textFieldInput
        textField.textColor = .textFieldInputColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.contentVerticalAlignment = .bottom
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    
    /// MARK: - button for SignUp
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Присоединиться", for: .normal)
        button.titleLabel?.font =  .buttonTitle
        button.backgroundColor = .buttonColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.Buttons.cornerRadius
        
        let gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didLongPressSignUpButton)
        )
        gesture.minimumPressDuration = Constants.Buttons.minPressDuration
        button.addGestureRecognizer(gesture)
        
        return button
    }()
    
    
    /// MARK: - container view for textFilds, placeholders and underlines
    private lazy var containerTextFieldsView: UIView = {
        let container: UIView = UIView()
        
        container.backgroundColor = .white
        
        return container
    }()
    
    
    /// MARK: - label containing registration rules P.S.
    private lazy var labelPS: UILabel = {
        let lable: UILabel = UILabel()
        
        lable.text = "Нажимая “Присоединиться”, вы принимаете Условия использования и Политику конфиденциальности  PointMe"
        lable.numberOfLines = 2
        lable.font = .authPS
        lable.textAlignment = .center
        lable.textColor = .authPS
        
        return lable
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupContainerTextFields()
        setupButtonAndLabelPS()
    }
    
    
    private func setupNavigationBar() {
        self.title = "PointMe"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    
    private func setupContainerTextFields() {
        [textFieldUsername, textFieldEmail, textFieldPassword].forEach {
            containerTextFieldsView.addSubview($0)
            
        }
        
        [labelForUsername, labelForEmail, labelForPassword].forEach {
            containerTextFieldsView.addSubview($0)
        }
        
        underlines.forEach {
            containerTextFieldsView.addSubview($0)
        }
        
        view.addSubview(containerTextFieldsView)
    }
    
    
    private func setupButtonAndLabelPS() {
        view.addSubview(signUpButton)
        view.addSubview(labelPS)
    }
    
    
    // MARK: Setup Layout
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayoutContainerTextFields()
        setupLayoutButtonSingUp()
        setupLayoutLabelPS()
    }
    
    
    private func setupLayoutContainerTextFields() {
        var offsetByCenter: CGFloat = 0
        var indexUnderline: Int = 0
        
        containerTextFieldsView.pin
            .horizontally(Constants.ContainerTextFields.horizontalMarginContainer)
        
        [textFieldPassword, textFieldEmail, textFieldUsername].forEach {
            $0.pin.height(Constants.ContainerTextFields.heightTextFileld)
                .horizontally(Constants.ContainerTextFields.horizontalMarginTextField)
                .bottom(offsetByCenter + 1)
            
            underlines[indexUnderline].pin.below(of: $0)
                .horizontally()
                .height(Constants.ContainerTextFields.widthUnderline)
            
            indexUnderline += 1
            offsetByCenter += Constants.ContainerTextFields.spacingBetweenTextFields
        }
        
        labelForUsername.pin.above(of: textFieldUsername)
            .horizontally()
            .height(labelForUsername.font.pointSize)
        
        labelForEmail.pin.above(of: textFieldEmail)
            .horizontally()
            .height(labelForEmail.font.pointSize)
        
        labelForPassword.pin.above(of: textFieldPassword)
            .horizontally()
            .height(labelForPassword.font.pointSize)
        
        containerTextFieldsView.pin
            .bottom(view.bounds.height / 2)
            .wrapContent()
    }
    
    
    private func setupLayoutButtonSingUp() {
        signUpButton.pin.below(of: containerTextFieldsView)
            .horizontally(Constants.Buttons.marginHorizontalSignUpButton)
            .height(Constants.Buttons.heightSignUpButton)
            .marginTop(Constants.Buttons.marginTopSignUpButton)
    }
    
    
    private func setupLayoutLabelPS() {
        labelPS.pin
            .height(Constants.LabelPS.heightLabel)
            .bottom(view.safeAreaInsets.bottom)
            .horizontally(Constants.LabelPS.hotizontalMargin)
        
    }
    
    
    // MARK: Setup targets for buttons
    
    
    @objc private func didLongPressSignUpButton(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            UIView.animate(withDuration: Constants.Buttons.durationAnimation) { [weak self] in
                self?.signUpButton.alpha = Constants.Buttons.tapOpacity
            }
        }
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: Constants.Buttons.durationAnimation) { [weak self] in
                self?.signUpButton.alpha = Constants.Buttons.identityOpacity
            } completion: { [weak self] _ in
                print("SignUp success!")
            }
        }
    }
}


private extension SignUpViewController {
    /// MARK: - constans values
    private struct Constants {
        // for buttons
        struct Buttons {
            // for buttons activity
            static let tapOpacity: CGFloat = 0.7
            static let identityOpacity: CGFloat = 1.0
            static let cornerRadius: CGFloat = 10
            static let durationAnimation: TimeInterval = 0.1
            static let minPressDuration: TimeInterval = 0
            
            // for signUp layout
            static let heightSignUpButton: CGFloat = 56
            static let marginTopSignUpButton: CGFloat = 60
            static let marginHorizontalSignUpButton: CGFloat = 20
        }
        
        // for container
        struct ContainerTextFields {
            // for container
            static let horizontalMarginContainer: CGFloat = 20
            
            // for underlines
            static let widthUnderline: CGFloat = 1.0
            
            // for textFields
            static let countTextFields: Int = 3
            static let spacingBetweenTextFields: CGFloat = 70
            static let horizontalMarginTextField: CGFloat = 1
            static let heightTextFileld: CGFloat = 40
        }
        
        // for labelPS
        struct LabelPS {
            static let hotizontalMargin: CGFloat = 18
            static let bottomMargin: CGFloat = 18
            static let heightLabel: CGFloat = 50
        }
    }
}

