import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/API%20model/new_model.dart';
import 'package:news_app/news_screen/cubit.dart';
import 'package:news_app/news_screen/states.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ScreenCubit()..getNews(),
      child: BlocConsumer<ScreenCubit , NewsState>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {
          return Scaffold(
            // backgroundColor: Colors.grey[300],
            appBar: AppBar(title: Text('News') , backgroundColor: Colors.deepPurpleAccent,),
            body: ConditionalBuilder(
              // condition: ScreenCubit.get(context).articles.length >0,
              condition: state is SuccessNewsState,
              builder: (BuildContext context) => ListView.separated(
                itemBuilder: (BuildContext context , int index) => myScreen(ScreenCubit.get(context).newModel,index),
                itemCount: ScreenCubit.get(context).newModel.articles.length,
                separatorBuilder:(BuildContext context , int index) =>  Container(height: 3.0 , color: Colors.grey[500],),
              ),
              fallback: (ctx) => Center(child: CircularProgressIndicator(),),

            )

        );
        }

      ),
    );
  }

 Widget myScreen(NewModel articles ,int index) =>
   Padding(
     padding: const EdgeInsets.all(10.0),
     child: Row(
       children: [
         Container(
          height: 120,
          width: 150,
          child: Image(image: NetworkImage(articles.articles[index].urlToImage ??
          'https://www.google.com/search?q=football&client=firefox-b-d&sxsrf=ALeKk03zYRt8-eT63D8ph02iGKgU0xDvKg:1628219111986&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjD1KTutJvyAhWKFxQKHUQeCt8Q_AUoAXoECAEQAw&biw=1408&bih=678#imgrc=65nV8bu303lXpM',),
               fit: BoxFit.cover),
               ),
            SizedBox(width: 10.0,),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 // mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text ('${articles.articles[index].title}',
                     style: TextStyle(color: Colors.grey[700] ,fontSize: 16, fontWeight: FontWeight.w700),
                     maxLines: 2,),
                   SizedBox(height: 10.0),
                   Text ('${articles.articles[index].source.name}',
                     style: TextStyle(color: Colors.grey[700] , fontSize: 13 , fontWeight: FontWeight.w400),),
                   SizedBox(height: 2.0),
                   Text ('${articles.articles[index].publishedAt}',
                     style: TextStyle(color: Colors.grey[700] , fontSize: 13 , fontWeight: FontWeight.w400),)
                 ],
               ),
             ),
       ],
     ),
   );


}


