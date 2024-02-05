import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:bharat_internship_task_02/const/const.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherFactory _wf = WeatherFactory(api_key);
  Weather? _weathers;
  late String nameCity;

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _textEditingController.text == ""
            ? Text(
                'Enter your city',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                _weathers?.areaName ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Search Cities'),
                    content: TextField(
                      autofillHints: [AutofillHints.addressCity],
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          cityChange();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 255, 255),
                image: DecorationImage(
                  image: NetworkImage(
                    "http://openweathermap.org/img/wn/${_weathers?.weatherIcon}@4x.png",
                  ),
                ),
              ),
            ),
            _textEditingController.text == ""
                ? Text(
                    'check the weather..',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "${_weathers?.temperature?.celsius?.toStringAsFixed(0)}⁰ C",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _textEditingController.text == ""
                  ? Text('')
                  : Text(
                      "${_weathers?.date?.day}/${_weathers?.date?.month}/${_weathers?.date?.year}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ]),
            _textEditingController.text == ""
                ? Text('')
                : Text(
                    _weathers?.weatherDescription ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textEditingController.text == ""
                      ? Text('')
                      : Text(
                          "Max: ${_weathers?.tempMax?.celsius?.toStringAsFixed(0)} ⁰ C",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textEditingController.text == ""
                      ? Text('')
                      : Text(
                          "Min: ${_weathers?.tempMin?.celsius?.toStringAsFixed(0)} ⁰ C",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _textEditingController.text == ""
                        ? Text('')
                        : Text(
                            "Wind: ${_weathers?.windSpeed?.toStringAsFixed(0)}m/s",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textEditingController.text == ""
                      ? Text('')
                      : Text(
                          "Humidity: ${_weathers?.humidity?.toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void cityChange() {
    setState(() {
      nameCity = _textEditingController.text;
      _getWeatherData(nameCity);
    });
  }

  void _getWeatherData(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weathers = w;
      });
    });
  }
}
