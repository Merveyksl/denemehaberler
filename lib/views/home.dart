import 'package:denemehaberler/alert/dialogAlert.dart';
import 'package:denemehaberler/hakk%C4%B1nda/hakk%C4%B1nda.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:denemehaberler/helper/data.dart';
import 'package:denemehaberler/helper/news.dart';
import 'package:denemehaberler/models/article_model.dart';
import 'package:denemehaberler/models/category_model.dart';
import 'package:denemehaberler/views/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'category_news.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles= [];
  bool _loading = true;

  @override
  void initState()  {
    super.initState();
    categories= getCategories();
    getNews();

  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });

  }


  showAlertDialog(BuildContext context) {

    Widget okButton = FlatButton(
      child: Text("EVET"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );
    Widget noButton = FlatButton(
      child: Text("HAYIR"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ÇIKIŞ"),
      content: Text("Çıkış yapmak istediğinize emin misiniz?"),
      actions: [
        okButton,
        noButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(''),
            ),
            ListTile(
              title: Text(''),
              onTap: () {
                // Update the state of the app.
                // ...
              },

            ),
            ListTile(
              title: Text('İletişim'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
              leading: Icon(Icons.contact_support),

            ),
            ListTile(
              title: Text('Hakkımızda'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute (builder: (context) => Hakkinda()));
              },
              leading: Icon(Icons.account_box_outlined),
            ),
            ListTile(
              title: Text('Çıkış'),
              onTap: () {
                 showAlertDialog(context);
              },
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text ("Haber"),
            Text("Bülteni", style:TextStyle ( color: Colors.black
            ),),
          ]
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute (builder: (context) => Hakkinda()));
            },
            child: Text('Hakkında'),
          ),

        ),
              ///Categories
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName.toString(),
                    );
                    }),
              ),

              ///Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,

                    );
                    }),
              )
            ],
          ),

        ),
      )
    );
  }
}
class CategoryTile extends StatelessWidget {

  final String imageUrl, categoryName,text;
  CategoryTile({this.imageUrl, this.categoryName, this.text,});

  @override
  Widget build(BuildContext context) {
    var cName="";
    if(categoryName.compareTo("İş")==1){
      cName="business";
    }else{
      cName="entertainment";
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: cName.toLowerCase(),
            )
        ));

      },
      child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 60,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),*/
                color: Colors.black26,
                child: Text(categoryName, style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),),

              )

            ],


          )
      ),
    );
  }

}



class  BlogTile extends StatelessWidget{
  final String  imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl, this.title, this.desc,   @required this.url });
  @override
  Widget build (BuildContext context){
    return  GestureDetector(
      onTap: (){
     Navigator.push(context, MaterialPageRoute(
     builder: (context) => ArticleView(
       blogUrl: url,

    )
     ));

    },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)
            ),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            )),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}
