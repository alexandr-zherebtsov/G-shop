import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/ui/widgets/exception_widget.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

enum _ViewModelBuilderType { NonReactive, Reactive }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelBuilderConnect<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;

  /// Fires once when the viewmodel is created or set for the first time
  ///
  /// If you want this to fire everytime the widget is inserted set [createNewModelOnInsert] to true
  final Function(T) onModelReady;

  /// Builder function with access to the model to build UI form
  final Widget Function(BuildContext, T, Widget) builder;

  /// A builder function that returns the viewmodel for this widget
  final T Function() viewModelBuilder;

  /// Indicates if you want Provider to dispose the viewmodel when it's removed from the widget tree.
  ///
  /// default's to true
  final bool disposeViewModel;

  /// When set to true a new ViewModel will be constructed everytime the widget is inserted.
  ///
  /// When setting this to true make sure to handle all disposing of streams if subscribed
  /// to any in the ViewModel. [onModelReady] will fire once the viewmodel has been created/set.
  /// This will be used when on re-insert of the widget the viewmodel has to be constructed with
  /// a new value.
  final bool createNewModelOnInsert;

  final _ViewModelBuilderType providerType;

  /// Indicates if the onModelReady should fire every time the model is inserted into the widget tree.
  /// Or only once during the lifecycle of the model.
  final bool fireOnModelReadyOnce;

  /// Indicates if we should run the initialise functionality for special viewmodels only once
  final bool initialiseSpecialViewModelsOnce;

  /// Constructs a viewmodel provider that will not rebuild the provided widget when notifyListeners is called.
  ///
  /// Widget from [builder] will be used as a staic child and won't rebuild when notifyListeners is called
  const ViewModelBuilderConnect.nonReactive({
    @required this.builder,
    @required this.viewModelBuilder,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    this.fireOnModelReadyOnce = false,
    this.initialiseSpecialViewModelsOnce = false,
    Key key,
  })  : providerType = _ViewModelBuilderType.NonReactive,
        staticChild = null,
        super(key: key);

  /// Constructs a viewmodel provider that fires the [builder] function when notifyListeners is called in the viewmodel.
  const ViewModelBuilderConnect.reactive({
    @required this.builder,
    @required this.viewModelBuilder,
    this.staticChild,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    this.fireOnModelReadyOnce = false,
    this.initialiseSpecialViewModelsOnce = false,
    Key key,
  })  : providerType = _ViewModelBuilderType.Reactive,
        super(key: key);

  @override
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends ChangeNotifier>
    extends State<ViewModelBuilderConnect<T>> {
  T _model;
  String connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool noInternet = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_model == null) {
      _createViewModel();
    }
    // Or if the user wants to create a new model whenever initState is fired
    else if (widget.createNewModelOnInsert) {
      _createViewModel();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _createViewModel() {
    if (widget.viewModelBuilder != null) {
      _model = widget.viewModelBuilder();
    }

    if (widget.initialiseSpecialViewModelsOnce &&
        !(_model as BaseViewModel).initialised) {
      _initialiseSpecialViewModels();
      (_model as BaseViewModel)?.setInitialised(true);
    } else if (!widget.initialiseSpecialViewModelsOnce) {
      _initialiseSpecialViewModels();
    }

    // Fire onModelReady after the model has been constructed
    if (widget.onModelReady != null) {
      if (widget.fireOnModelReadyOnce &&
          !(_model as BaseViewModel).onModelReadyCalled) {
        widget.onModelReady(_model);
        (_model as BaseViewModel)?.setOnModelReadyCalled(true);
      } else if (!widget.fireOnModelReadyOnce) {
        widget.onModelReady(_model);
      }
    }
  }

  void _initialiseSpecialViewModels() {
    // Add any additional actions here for spcialised ViewModels
    // Add any additional actions here for spcialised ViewModels
    if (_model is Initialisable) {
      (_model as Initialisable).initialise();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelBuilderType.NonReactive) {
      if (!widget.disposeViewModel) {
        return ChangeNotifierProvider.value(
          value: _model,
          child: noInternet
              ? withoutInternet()
              : widget.builder(context, _model, widget.staticChild),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => _model,
        child: noInternet
            ? withoutInternet()
            : widget.builder(context, _model, widget.staticChild),
      );
    }

    if (!widget.disposeViewModel) {
      return ChangeNotifierProvider.value(
        value: _model,
        child: noInternet
            ? withoutInternet()
            : Consumer(
          builder: builderWithDynamicSourceInitialise,
          child: widget.staticChild,
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => _model,
      child: noInternet
          ? withoutInternet()
          : Consumer(
        builder: builderWithDynamicSourceInitialise,
        child: widget.staticChild,
      ),
    );
  }

  Widget builderWithDynamicSourceInitialise(
      BuildContext context, T model, Widget child) {
    if (model is DynamicSourceViewModel) {
      if (model.changeSource ?? false) {
        _initialiseSpecialViewModels();
      }
    }
    return noInternet
        ? withoutInternet()
        : widget.builder(context, model, child);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        setState(() {
          connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
          noInternet = false;
        });

        break;
      case ConnectivityResult.mobile:
        setState(() {
          connectionStatus = 'mobile';
          noInternet = false;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          connectionStatus = result.toString();
          noInternet = true;
        });
        break;
      default:
        setState(() => connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Widget withoutInternet() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ExceptionWidget(
        title: textNetworkError,
        img: imgDrumsVector,
        isError: true,
      ),
    );
  }
}

/// EXPERIMENTAL: Returns the ViewModel provided above this widget in the tree
T getParentViewModel<T>(BuildContext context) => Provider.of<T>(context);
