import 'package:flutter/material.dart';
import 'package:go_caffeine_coding_test/api.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key,required this.imdb});

  final String imdb;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.grey,
          leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        ),
        body: SizedBox(
          child: FutureBuilder(
            future: ApiData.getMovieDetailData(imdb),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error} 이러한 에러로 인해서 현재 호출이 불가합니다.'));
              } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('검색을 잘 못 하셨습니다.'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: height / 2,
                        child: Image.network(snapshot.data!["Poster"],fit: BoxFit.contain,)),
                      Text("제목 : ${snapshot.data!["Title"]}"),
                      Text("개봉날짜 : ${snapshot.data!["Released"]}"),
                      Text("줄거리 : ${snapshot.data!["Plot"]}"),
                      Text("평점"),
                      for(final rating in snapshot.data!["Ratings"])
                      Text("${rating["Source"]} : ${rating["Value"]}")
                      // Text(snapshot.data!["Ratings"].first),
                    ],
                  ),
                );
              } 
            }
          ),
        ),
      ),
    );
  }
}
