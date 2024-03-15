import UIKit
import Combine

final class CSListView: UIView {
    private var cancellable = Set<AnyCancellable>()
    private var viewModel: CSListViewModel!
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(resource: .background)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: CSListViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setBinding()
        setLayout()
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBinding() {
        viewModel.$items
            .sink { [weak self] items in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    private func setLayout() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    func setDelegate(delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
    
    func setDataSource(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
}