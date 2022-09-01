import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/login_screen.dart';
import 'package:khwass_app/network/local/cache_helper.dart';
import 'package:khwass_app/shaerd/components/components.dart';
import 'package:khwass_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String desc;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.desc
  });

}

class BoardingShoppingApp extends StatefulWidget {

  @override
  _BoardingShoppingAppState createState() => _BoardingShoppingAppState();
}

class _BoardingShoppingAppState extends State<BoardingShoppingApp> {
  var boarderControl= PageController();

  List <BoardingModel> boardingItems=
  [
    BoardingModel(
      image: 'assets/images/m_1.png',
      title: 'Mohamed Ali Khwass' ,
      desc: 'mohamed' ,
    ),
    BoardingModel(
      image: 'assets/images/m_2.png',
      title: 'Mohamed Ali Khwass' ,
      desc: 'ali' ,
    ),
    BoardingModel(
      image: 'assets/images/m_3.png',
      title: 'Mohamed Ali Khwass' ,
      desc: 'khwass' ,
    ),
  ];

  bool isLast=false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,)
        .then((value)
    {
    if(value  )
    {
      navigatorToAndFinch(context,ShopAppLogin());
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:submit,
              child:Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 10.0,
                ),
              ),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                 onPageChanged: (index)
                 {
                   if(index==boardingItems.length-1)
                   {
                     print(' lost');
                     setState(() {
                       isLast=true;
                     });
                   }
                  else
                    {
                      print(' not lost');
                      setState(() {
                        isLast=false;
                      });
                    }

                 },
                  itemBuilder: (context,index)=>buildItemBoarding(boardingItems[index]),
                  itemCount: boardingItems.length,
                physics:BouncingScrollPhysics() ,
                controller:boarderControl ,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boarderControl,
                  count: boardingItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    radius: 50.0,
                    spacing: 10,

                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child:Icon(
                    Icons.arrow_forward_ios,
                  ) ,

                    onPressed: ()
                    {
                      if(isLast)
                        {
                          submit();
                        }
                      else {
                        boarderControl.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeInBack,
                        );
                      }
                    }


                    ),


              ],

            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }

  Widget buildItemBoarding(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),


      Text(
        '${model.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        '${model.desc}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    ],
  );
}
