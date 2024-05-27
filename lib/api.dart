import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiData {
  static Future<List?> getMovieList(String text) async {
    try {
      var response = await http.get(Uri.parse("https://www.omdbapi.com/?apikey=702a39ac&s=$text&page=1&type=movie"));
      if(response.statusCode == 200){
        // debugPrint("결과값 체크 : ${response.body}");
        Map searchList =  json.decode(response.body);
        return searchList["Search"];
      } else {
        throw Exception("영화 목록 호출 에러 ::: ${response.statusCode}");
      }
    } catch(e){
      debugPrint("영화목록 호출 실패 ::: $e");
    }
  }

  static Future<Map?> getMovieDetailData(String imdb) async {
    try {
      var response = await http.get(Uri.parse("https://www.omdbapi.com/?i=$imdb&apikey=702a39ac"));
      if(response.statusCode == 200){
        // debugPrint("결과값 체크 : ${response.body}");
        return json.decode(response.body);
      } else {
        throw Exception("영화 상세데이터 호출 실패 ::: ${response.statusCode}");
      }
    } catch(e){
      debugPrint("영화데이터 호출 실패 ::: $e");
    }
  }
}