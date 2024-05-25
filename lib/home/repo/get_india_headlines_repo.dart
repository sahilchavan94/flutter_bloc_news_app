import 'dart:convert';
import 'package:flutternews/model/article_model.dart';
import 'package:http/http.dart' as http;

//method to get top headlines related to india

class GetIndiaHeadlines {
  //method to get data
  static dynamic getIndianHeadlines() async {
    //defining the url
    const url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=b1f0cf2d3c2c4c2d926590c5c59073bc';

    //try catch to fetch data
    try {
      //response object
      var response = await http.get(Uri.parse(url));

      //convert the response from a string to a json object with json.decode
      Map<String, dynamic> list = json.decode(response.body);

      //storing the articles in a separate local variable which is a dynamic List
      List<dynamic> articleRawList = list["articles"];

      //creating a list of Article models
      List<ArticleModel> articleModelList = articleRawList
          .map((article) => ArticleModel(
              source: article['source']['name'],
              author: article['author'],
              title: article['title'],
              description: article['description'],
              articleUrl: article['url'],
              imageUrl: article["urlToImage"],
              publishedAt: article["publishedAt"],
              content: article["content"]))
          .toList();

      //return the result in form a Map
      Map<String, dynamic> result = {
        "articleList": articleModelList,
        "totalResults": articleModelList.length,
        "success": true
      };

      //return statement
      return result;
    } catch (e) {
      //if there is any error then return false
      return false;
    }
  }
}
