import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> sehirler = [
    "Ankara",
    'Bursa',
    'İzmir',
    'İstanbul',
    'Van',
    'Antalya'
  ];

  String? secilenSehir;
  Future<WeatherModel>? weatherFuture;

  void selectedCity(String sehir) {
    setState(() {
      secilenSehir = sehir;
      weatherFuture = getWeather(sehir);
    });
  }

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    queryParameters: {
      "appid": '5ff5f6121eced2f3ad373070cbbb2040',
      "lang": 'tr',
      "units": "metric"
    },
  ));

  Future<WeatherModel> getWeather(String secilenSehir) async {
    final response =
        await dio.get('/weather', queryParameters: {"q": secilenSehir});

    var model = WeatherModel.fromJson(response.data);
    debugPrint(model.main?.temp.toString());
    return model;
  }

  Widget _buildWeatherCard(WeatherModel weatherModel) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              weatherModel.name!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${weatherModel.main!.temp!.round()}°",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(weatherModel.weather![0].description ?? 'Değer Bulunamadı'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(weatherModel.main!.humidity!.round().toString())
                  ],
                ),
                const SizedBox(
                  width: 32,
                ),
                Column(
                  children: [
                    const Icon(Icons.air),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(weatherModel.wind!.speed!.round().toString())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hava Durumu'),
        ),
        body: Column(
          children: [
            if (weatherFuture != null)
              FutureBuilder(
                future: weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return _buildWeatherCard(snapshot.data!);
                  }
                  return const SizedBox();
                },
              ),
            Expanded(
                child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
              itemBuilder: (context, index) {
                final isSelected = secilenSehir == sehirler[index];
                return GestureDetector(
                  onTap: () => selectedCity(sehirler[index]),
                  child: Card(
                    color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
                    child: Center(
                      child: Text(sehirler[index]),
                    ),
                  ),
                );
              },
              itemCount: sehirler.length,
            )),
          ],
        ));
  }
}
