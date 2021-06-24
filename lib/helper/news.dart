import 'package:http/http.dart' as http;
import 'package:denemehaberler/models/article_model.dart';
import 'dart:convert';

//import 'package:denemehaberler/secret.dart';

class News {

  List<ArticleModel> news  = [];
  var apiKey = '7c10ed865e574be4b4f851daf3ee9c6e';

  Future<void> getNews() async{
  //  String url = "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=7c10ed865e574be4b4f851daf3ee9c6e";
    String url = "https://newsapi.org/v2/top-headlines?country=tr&apiKey=7c10ed865e574be4b4f851daf3ee9c6e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel article = ArticleModel(
            author: element['author'].toString(),
            title: element['title'].toString(),
            description: element['description'].toString(),
            url: element['url'].toString(),
            urlToImage: element['urlToImage'].toString(),
            content: element["content"].toString(),
          );
          news.add(article);
        }

      });
    }


  }


}


class NewsForCategorie {

  List<ArticleModel> news  = [];
  var apiKey = "7c10ed865e574be4b4f851daf3ee9c6e";

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
   String url = "http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";


    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel article = ArticleModel(
            author: element['author'].toString(),
            title: element['title'].toString(),
            description: element['description'].toString(),
            url: element['url'].toString(),
            urlToImage: element['urlToImage'].toString(),
            content: element["content"].toString(),
          );
          news.add(article);
        }

      });
    }


  }


}

