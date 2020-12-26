import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:habr_clean_architecture/domain/state/home/home_state.dart';
import 'package:habr_clean_architecture/internal/dependencies/home_module.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  HomeState _homeState;

  @override
  void initState() {
    _homeState = HomeModule.homeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getRowInput(),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Получить'),
              onPressed: _getDay,
            ),
            SizedBox(height: 20),
            _getDayInfo(),
          ],
        ),
      ),
    );
  }

  Widget _getRowInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _latController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(hintText: 'Широта'),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _lngController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(hintText: 'Долгота'),
          ),
        ),
      ],
    );
  }

  Widget _getDayInfo() {
    return Observer(builder: (_) {
      if (_homeState.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (_homeState.day == null) return Container();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Восход: ${_homeState.day.sunrise.toLocal()}'),
          Text('Заход: ${_homeState.day.sunset.toLocal()}'),
          Text('Полдень: ${_homeState.day.solarNoon.toLocal()}'),
          Text(
              'Продолжительность: ${Duration(seconds: _homeState.day.dayLength)}'),
        ],
      );
    });
  }

  void _getDay() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    _homeState.getDay(latitude: lat, longitude: lng);
  }
}
