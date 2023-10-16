import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterDelegate {
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory.delegate = self
        alertPresenter.delegate = self
        questionFactory.requestNextQuestion(0)
    }
    
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    func didReceiveAlert() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory.requestNextQuestion(currentQuestionIndex)
    }
    
    // переменная с индексом текущего вопроса, начальное значение 0
    // (по этому индексу будем искать вопрос в массиве, где индекс первого элемента 0, а не 1)
    private var currentQuestionIndex = 0
    
    // переменная со счётчиком правильных ответов, начальное значение закономерно 0
    private var correctAnswers = 0
    
    // количество сыгранных квизов
    private var currentQuizCount = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol = QuestionFactory() as QuestionFactoryProtocol
    private var alertPresenter: AlertPresenterProtocol = ResultAlertPresenter() as AlertPresenterProtocol
    private var currentQuestion: QuizQuestion?
    private var statisticService: StatisticService = StatisticServiceImplementation()
    
    private func currentDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let result = "(\(day).\(month).\(year) \(hour):\(minutes))"
        return result
    }
    
    // метод конвертации, который принимает моковый вопрос и возвращает вью модель для экрана вопроса
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
            return questionStep
    }
    
    // приватный метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    // приватный метод, который меняет цвет рамки
    // принимает на вход булевое значение и ничего не возвращает
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
                correctAnswers += 1
        }
        // метод красит рамку
        imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
        imageView.layer.borderWidth = 8 // толщина рамки по макету
        imageView.layer.cornerRadius = 20 // по макету
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor // красим рамку в зависимости от корректности ответа

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // возвращаем обработку нажатий кнопкок "Да/Нет"
                self.yesButton.isEnabled = true
                self.noButton.isEnabled = true
                self.showNextQuestionOrResults()
            }
    }
    // приватный метод, который содержит логику перехода в один из сценариев
    // метод ничего не принимает и ничего не возвращает
    private func showNextQuestionOrResults() {
        imageView.layer.borderWidth = 0 // убираем толщину рамки
        
        if currentQuestionIndex == questionsAmount - 1 {
            // Увеличиваем число завершенных квизов на 1
            currentQuizCount += 1
            // Из класса statisticServiceImplementation получаем статистику для вывода в alert и сохраняем полученные данные
            let stats = statisticService.getStats(correct: correctAnswers, total: 10, quizCount: currentQuizCount)
            let viewModel = AlertModel(
                title: "Этот раунд окончен!",
                message: stats,
                buttonText: "Сыграть ещё раз")
            alertPresenter.showResult(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            questionFactory.requestNextQuestion(currentQuestionIndex)
        }
    }
    
    @IBOutlet weak private var imageView: UIImageView!
    
    @IBOutlet weak private var textLabel: UILabel!
    
    @IBOutlet weak private var counterLabel: UILabel!

    @IBOutlet weak private var noButton: UIButton!
    
    @IBOutlet weak var yesButton: UIButton!
    
    
    // метод вызывается, когда пользователь нажимает на кнопку "Нет"
    @IBAction private func noButtonClicked(_ sender: Any) {
        // отключаем кнопки до момента обработки результатов
        noButton.isEnabled = false
        yesButton.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        let getAnswer = false
        
        showAnswerResult(isCorrect: getAnswer == currentQuestion.correctAnswer)
    }

    // метод вызывается, когда пользователь нажимает на кнопку "Да"
    @IBAction private func yesButtonClicked(_ sender: Any) {
        // отключаем кнопки до момента обработки результатов
        noButton.isEnabled = false
        yesButton.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        let getAnswer = true

        showAnswerResult(isCorrect: getAnswer == currentQuestion.correctAnswer)
    }
}
