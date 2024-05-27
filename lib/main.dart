import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_caffeine_coding_test/api.dart';
import 'package:go_caffeine_coding_test/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController searchText = TextEditingController(text: "star");

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      // appBar: AppBar(),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(child: Text("검색어 입력"))),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: searchText,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {

                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("검색"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: ApiData.getMovieList(searchText.text),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error} 이러한 에러로 인해서 현재 호출이 불가합니다.'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('검색 결과가 없거나 너무 많은 검색 결과가 있습니다.'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          // ApiData.getMovieDetailData(snapshot.data![index]["imdbID"]);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailPage(imdb : snapshot.data![index]["imdbID"])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex:1,
                                  child: Image.network(snapshot.data![index]["Poster"])),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(snapshot.data![index]["Title"],maxLines: 2,)),
                                        Expanded(
                                          flex: 3,
                                          child: Text("개봉연도 : ${snapshot.data![index]["Year"]}",maxLines: 3,)),
                                      ],
                                    ),
                                  )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },itemCount: snapshot.data!.length,),
                  );
                }
            })

          ],
        ),
      ),
    ));
  }
}
