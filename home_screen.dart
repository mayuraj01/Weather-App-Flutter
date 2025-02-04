import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  
  Weather? _weather;
  
  void _getWeather() async{
    setState(() {
      _isLoading = true;
    });

    try{
      final weather = await _weatherServices.fetchWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    }catch(e){
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error featching weather data")),
        );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        
        decoration: BoxDecoration(
          gradient: _weather != null && _weather!.description.toLowerCase().contains('rain')
          ? const LinearGradient(
            colors: [Colors.grey, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
          : _weather != null && _weather!.description.toLowerCase().contains('clear')
          ? const LinearGradient(
            colors: [Colors.orangeAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
          : const LinearGradient(
            colors: [Colors.grey , Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),

        child: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  const Text('Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  ),
          
                  const SizedBox(height: 25,),
          
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "Enter your City Name",
                          hintStyle: const TextStyle(color: Color.fromARGB(122, 255, 255, 255)),
                          filled: true,
                          fillColor:const Color.fromARGB(125, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
          
                  ElevatedButton(
                    onPressed: _getWeather,
                    child: Text("Get Weather" , style: TextStyle(fontSize: 18,),),
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: const Color.fromARGB(211, 96, 125, 140),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),),),
                    ),
                    if(_isLoading)
                      Padding(padding: EdgeInsets.all(20), child:  CircularProgressIndicator(color: Colors.white),),
                    
          
                    if(_weather != null)
                      WeatherCard(weather: _weather!)
                    
          
          
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

