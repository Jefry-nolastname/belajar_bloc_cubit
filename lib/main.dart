import 'package:coba_bloc/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context)=>WeatherCubit(FakeWeatherRepository()),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocConsumer<WeatherCubit,WeatherState>(
        listener: (context,state){
          if(state is WeatherError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context,state){
          if(state is WeatherInitial){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }
          else if (state is WeatherLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is WeatherLoaded) {
            return Center(child: Text(state.weather.cityName),);
          }
          else{
              return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          const Text(
          'You have pushed the button this many times:',
          ),
          Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
          ),
          ],
          ),
          );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final _weatherCubit = BlocProvider.of<WeatherCubit>(context);
          _weatherCubit.getWeather("Palembang");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
