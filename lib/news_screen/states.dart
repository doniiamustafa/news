abstract class NewsState{}
class InitialNewsState extends NewsState{}
class LoadingsNewsState extends NewsState{}
class SuccessNewsState extends NewsState{}
class FailedNewsState extends NewsState{
  String error;
  FailedNewsState({this.error});    // 7ateto f constructor 3lshan law 3yza ab3at el error da yezharli f toast aw message
}
