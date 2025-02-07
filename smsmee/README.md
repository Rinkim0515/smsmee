# 씀씀이 version2 ( MVI + RxSwift )

## 프로젝트 개요


이 프로젝트는 기존에 `MVC`아키텍쳐로 설계되었으나 현재는 `MVVM` + `MVI`아키텍처를 기반으로 설계를 하였습니다.

또한 객체지향프로그래밍의 SOLID 원칙과 유지보수성에 대해 고려하며 제작되었습니다.

## 1. 주요 설계 원칙 

### View, ViewModel의 추상화 (BaseView, BaseViewModel)


 

```swift

class BaseViewModel<Intent: BaseIntent, State: BaseState> {
    let disposeBag = DisposeBag()
    
    let intentRelay = PublishRelay<Intent>()
    let stateRelay = BehaviorRelay<State>(value: State.idle)
    
    var state: Driver<State> { stateRelay.asDriver() }
    
    init() { transform() }
    
    func transform() { }
    
    func updateState(_ newState: State) {
        stateRelay.accept(newState)
    }
}

```



-  가독성을 높히기 위해 extension으로 따로 분리하여 메서드의 기능, 역할에 따라 `//MARK: - Rendering`  이러한 방식으로 구분하였습니다.  



- ViewModel은 BaseIntent,BaseState 프로토콜을 채택한 Intent, State 를 받을수 있는 구조로 설계 
- intent 에 따른 state를 Driver로 Wrapping 하여서 VC에게 전달할수 있도록 

- VC에서는 화면의 터치 감지, View에게 화면 전환의 명령 으로써 SRP 을 준수하기 위해 노력했습니다. 

- View와 ViewModel은 추상화된 Base 클래스를 상속받아 재사용성을 높임.
- BaseViewModel은 Intent 및 State를 protocol로 추상화하여 다양한 ViewModel에서 공통적으로 활용 가능하도록 설계됨.
- `protocol`인 `ViewModelBindable`을 생성하여 ViewController 에 채택하여 사용할수 있도록 도입하였습니다. 
추후 유지보수적인 측면을 고려했을때 

```swift
protocol ViewModelBindable {
    associatedtype Intent: BaseIntent
    associatedtype State: BaseState
    associatedtype VM: BaseViewModel<Intent, State>

    var viewModel: VM { get }
    var disposeBag: DisposeBag { get }
    
    func bindViewModel()
    func render(state: State)
}

extension ViewModelBindable where Self: UIViewController {
    func bindViewModel() {
        viewModel.state
            .drive(onNext: { [weak self] state in
                self?.render(state: state)
            })
            .disposed(by: disposeBag)
    }
}

```




## 2. 프로젝트 아키텍처 구조 

### MVI 



## 3. 사용 기술  
RxSwift, Realm, Snapkit, DGCharts


## 4. 추후 방향성

### 
- FireBase의 도입
- Coordinator 패턴 도입 
