import 'package:denemehaberler/helper/news.dart';
import 'package:denemehaberler/helper/widgets.dart';
import 'package:denemehaberler/models/article_model.dart';
import 'package:denemehaberler/views/article_view.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist = [];
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.category);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newslist.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsTile(
                    title: newslist[index].title.toString() ?? "",
                    desc: newslist[index].description.toString() ?? "",
                    content: newslist[index].content.toString() ?? "",
                    posturl: newslist[index].articleUrl.toString() ?? "",
                  );
                }),
          ),
        ),
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