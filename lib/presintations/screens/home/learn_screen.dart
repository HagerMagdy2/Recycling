import 'package:firstly/presintations/screens/home/video_screen.dart';
import 'package:flutter/material.dart';

import 'articles_screen.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Videos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildVideoCard('إعادة التدوير', 'assets/images/v1.png',
                      context, 'videos/video1.mp4'),
                  SizedBox(
                    height: 10,
                  ),
                  _buildVideoCard('إعادة تدوير الإكسسوارات القديمة',
                      'assets/images/v2.png', context, 'videos/video2.mp4'),
                  SizedBox(
                    height: 10,
                  ),
                  _buildVideoCard('إعادة تدوير النفايات في المنزل',
                      'assets/images/v3.png', context, 'videos/video3.mp4'),
                ],
              ),
            ),
            SizedBox(height: 20), // Spacer between videos and articles
            Text(
              'articles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildArticleCard(
                      'إعادة التدوير',
                      'assets/images/a1.jpg',
                      context,
                      'تعريف إعادة تدوير الورق يُمكن تعريف إعادة تدوير الورق (بالإنجليزية: Paper recycling) بأنّها: عمليّة إنتاج أوراق جديدة يُمكن استخدامها من أوراق قديمة مُستهلَكة، وتُساعد هذه العمليّة على مَنع تراكُم الورق في مَكابّ النفايات، وتقليل التلوث وانبعاث غازات الدفيئة،[١] ممّا يجعلها عمليّة صديقة للبيئة تسمح بتوفير الطاقة والموارد على الرغم من كونها تستغرق وقتاً طويلاً.[٢] تاريخ البدء بإعادة تدوير الورق أسّس وليام ريتينهاوس (بالإنجليزية: William Rittenhouse) أوّل مطحنة للورق في الولايات المُتَّحِدة بعد تعلُّمه طريقة صناعة الورق في ألمانيا، وبدأت الولايات المُتَّحدة بإعادة تدوير الورق عام 1690م، إذ استخدم ريتينهاوس بقايا الملابس القطنيّة والكتّانية القديمة في صناعة الورق، وذلك إلى أن انتقل الناس إلى استخدام الأشجار والألياف الخشبية في صناعته في العقد الأول من القرن التاسع عشر، وبعدها أسّس ماتياس كوبس (بالإنجليزية: Matthias Koops) أوّل مطحنة للورق في إنجلترا عام 1801م، والتي كانت الأولى من نوعها في العالم لإنتاج الورق من موادّ غير القطن، والكتّان، إذ استخرج الحبر من الورق، وحوّل الورق إلى لبّ تُصنَع منه أوراق جديدة للكتابة، والطباعة، وذلك بعد أن حصل على أوّل براءة اختراع تتعلّق بتدوير الورق عام 1800م، وعلى الرغم من أنّ شركة كوبس أعلنت إفلاسها بعد عامَين من افتتاحها، إلّا أنّ طريقته استُخدِمت في مصانع الورق جميعها في العالم، ثمّ توالى افتتاح مراكز تدوير الورق في كلٍّ من بالتيمور الواقعة في ماريلاند وذلك عام 1874م، ثمّ في مدينة نيويورك عام 1896م، وتُعدّ عملية تدوير الورق عمليّةً ضخمةً يصل فيها وزن الورق المُعاد تدويره إلى أكثر من وزن الزجاج، والبلاستيك، والألومنيوم معاً.[٣] أهمّية إعادة تدوير الورق تعود أهميّة إعادة التدوير إلى قدرتها على إنقاذ 19 شجرة تُخلّص الغلاف الجوّي كلّ عام من 127كغم من ثاني أكسيد الكربون، وبما أنّ عملية صناعة الورق تستهلك الكثير من الموارد، فالتدوير يُساهم في توفير 1,500 لتر من النفط، و2.68م2 من مساحة مَكبّ النفايات، و4,400 كيلو واط من الطاقة، و29,000 لتر من الماء،[٤] كما أنّها تقلّل تلوُّث الهواء بنسبة 73% مقارنة بعمليّة صناعة ورق جديد، إضافةً إلى أنّ انتاج طنٍّ واحد من الصُّحف يحتاج إلى 24 شجرة،[٥] ناهيك عن كون تكلفة شراء الورق المُعاد تدويره أقلّ من تكلفة شراء ورق جديد، إلى جانب أنّ مصانع تدوير الورق، والعمليّة المتعلّقة توفّر وظائف للكثير من الناس.\n المراجع : ↑ Douglas Lober (26/10/2017), "Kids Super Guide to Recycling", ReuseThisBag, Retrieved 28/1/2022. ^ أ ب "The Environment Recycling ", DUCKSTERS, Retrieved 28/1/2022. ^ أ ب ت "Recycling Basics", EPA, Retrieved 31/1/2022.'),
                  SizedBox(
                    height: 10,
                  ),
                  _buildArticleCard(
                      'إعادة تدوير الورق', 'assets/images/a2.jpg', context, """ تعريف إعادة تدوير الورق يُمكن تعريف إعادة تدوير الورق (بالإنجليزية: Paper recycling) بأنّها: عمليّة إنتاج أوراق جديدة يُمكن استخدامها من أوراق قديمة مُستهلَكة، وتُساعد هذه العمليّة على مَنع تراكُم الورق في مَكابّ النفايات، وتقليل التلوث وانبعاث غازات الدفيئة،[١] ممّا يجعلها عمليّة صديقة للبيئة تسمح بتوفير الطاقة والموارد على الرغم من كونها تستغرق وقتاً طويلاً.[٢] تاريخ البدء بإعادة تدوير الورق أسّس وليام ريتينهاوس (بالإنجليزية: William Rittenhouse) أوّل مطحنة للورق في الولايات المُتَّحِدة بعد تعلُّمه طريقة صناعة الورق في ألمانيا، وبدأت الولايات المُتَّحدة بإعادة تدوير الورق عام 1690م، إذ استخدم ريتينهاوس بقايا الملابس القطنيّة والكتّانية القديمة في صناعة الورق، وذلك إلى أن انتقل الناس إلى استخدام الأشجار والألياف الخشبية في صناعته في العقد الأول من القرن التاسع عشر، وبعدها أسّس ماتياس كوبس (بالإنجليزية: Matthias Koops) أوّل مطحنة للورق في إنجلترا عام 1801م، والتي كانت الأولى من نوعها في العالم لإنتاج الورق من موادّ غير القطن، والكتّان، إذ استخرج الحبر من الورق، وحوّل الورق إلى لبّ تُصنَع منه أوراق جديدة للكتابة، والطباعة، وذلك بعد أن حصل على أوّل براءة اختراع تتعلّق بتدوير الورق عام 1800م، وعلى الرغم من أنّ شركة كوبس أعلنت إفلاسها بعد عامَين من افتتاحها، إلّا أنّ طريقته استُخدِمت في مصانع الورق جميعها في العالم، ثمّ توالى افتتاح مراكز تدوير الورق في كلٍّ من بالتيمور الواقعة في ماريلاند وذلك عام 1874م، ثمّ في مدينة نيويورك عام 1896م، وتُعدّ عملية تدوير الورق عمليّةً ضخمةً يصل فيها وزن الورق المُعاد تدويره إلى أكثر من وزن الزجاج، والبلاستيك، والألومنيوم معاً.[٣] أهمّية إعادة تدوير الورق تعود أهميّة إعادة التدوير إلى قدرتها على إنقاذ 19 شجرة تُخلّص الغلاف الجوّي كلّ عام من 127كغم من ثاني أكسيد الكربون، وبما أنّ عملية صناعة الورق تستهلك الكثير من الموارد، فالتدوير يُساهم في توفير 1,500 لتر من النفط، و2.68م2 من مساحة مَكبّ النفايات، و4,400 كيلو واط من الطاقة، و29,000 لتر من الماء،[٤] كما أنّها تقلّل تلوُّث الهواء بنسبة 73% مقارنة بعمليّة صناعة ورق جديد، إضافةً إلى أنّ انتاج طنٍّ واحد من الصُّحف يحتاج إلى 24 شجرة،[٥] ناهيك عن كون تكلفة شراء الورق المُعاد تدويره أقلّ من تكلفة شراء ورق جديد، إلى جانب أنّ مصانع تدوير الورق، والعمليّة المتعلّقة توفّر وظائف للكثير من الناس. \n المراجع : ↑ "What Is The Process Of Recycling Paper", www.norcalcompactors.net, Retrieved 24-11-2019. Edited. ↑ "A Step by Step Guide for Waste Paper Recycling Process", www.balajichemsolutions.com, Retrieved 24-11-2019. Edited. ↑ Larry West (26-6-2019), "What Are the Benefits of Paper Recycling?"، www.thoughtco.com, Retrieved 24-11-2019. Edited. ^ أ ب "How is Paper Recycled: The Recycling Process", www.greentumble.com,4-9-2018، Retrieved 24-11-2019. Edited. ↑ "Recycling facts and figures", www.recycling-guide.org.uk, Retrieved 24-11-2019. Edited. ↑ "What to do with PAPER", www.recyclenow.com, Retrieved 24-11-2019. Edited. ↑ "How to Make Recycled Paper", www.wikihow.com,24-9-2019، Retrieved 24-11-2019. Edited. ↑ "What Do Your Recyclables Become?", www.maine.gov, Retrieved 24-11-2019. Edited"""),
                  SizedBox(
                    height: 10,
                  ),
                  _buildArticleCard(
                      'إعادة تدوير الزيت ',
                      'assets/images/a3.jpeg',
                      context, """ طريقة تنقية الزيت المستعمل بالنشا:
الطريقة الأولى لتنقية زيت القلي المستعمل عدة مرات عبر وضع النشاء على نصف كوب من الماء ثم خلطها بشكل جيد. بعدها نضع الزيت المستخدم عدة مرات على النار ونضع عليه خليط النشاء بالماء. يترك على النار وقتا قليلا، بعدها يُصفى الزيت من النشاء ويستخدم.

طريقة تنقية الزيت المستعمل بالخل:
وتوجد طريقة أخرى لتنقية الزيت القديم، عبر إضافة الخل على الزيت، فالخل له قدرة عالية على تنظيف الشوائب وروائح الأكل المتواجدة في الزيت، وذلك عن طريق وضعه في إناء على النار وإضافة ربع كوب من الخل عليه ثم نتركه يغلي، وبعد ذلك يُصفى ليصبح صالحا للاستخدام.

إستخدامات أخرى:
ومن الممكن إضافة ملعقتين من الخل على ملعقتين من الزيت المستعمل ويضاف عليها نصف كوب من الماء، ثم يتم يستخدم الخليط في تنظيف أثاث المنزل.
يساعد الزيت في معالجة صدأ المعادن: ويمكن استخدام الزيت المستعمل في حفظ الأدوات المعدنية من الصدأ، وتسهيل فتح الأقفال.
عن طريق وضع ملعقتين من النشادر وملعقة من الملح وملعقتين من الخل وتقليبها ثم تركها حتى يتجمد. بعدها نستخدمه لتنظيف الأواني والألمونيوم.
يوضع كمية من الماء والقليل من الصابون ثم تقوم بتسخينها ويوضع أجزاء الشفاط الكهربائي بداخل الماء الساخن لربع ساعة، وباستخدام سلك مواعين وعليه خليط زيت الطعام والصابون وتمسح الدهون المتراكمة.
يوضع القليل من زيت الطعام على قطعة قماش وتمسح مناطق الأوساخ على سطح السيارة.
يعمل الزيت المستعمل على إزالة طلاء الحائط من الجسم، من خلال وضع القليل على الجزء الذي لامسه الطلاء ثم يفرك جيدًا ويترك لمدة خمس دقائق، ويغسل جيدا.
يستخدم الزيت المستعمل في تنعيم الأثاث المصنوع من الجلد والحفاظ عليه.

المراجع : ↑ "What Is The Process Of Recycling Paper", www.norcalcompactors.net, Retrieved 24-11-2019. Edited. ↑ "A Step by Step Guide for Waste Paper Recycling Process", www.balajichemsolutions.com, Retrieved 24-11-2019. Edited. ↑ Larry West (26-6-2019), "What Are the Benefits of Paper Recycling?"، www.thoughtco.com, Retrieved 24-11-2019. Edited. ^ أ ب "How is Paper Recycled: The Recycling Process", www.greentumble.com,4-9-2018، Retrieved 24-11-2019. Edited. ↑ "Recycling facts and figures", www.recycling-guide.org.uk, Retrieved 24-11-2019. Edited. ↑ "What to do with PAPER", www.recyclenow.com, Retrieved 24-11-2019. Edited. ↑ "How to Make Recycled Paper", www.wikihow.com,24-9-2019، Retrieved 24-11-2019. Edited. ↑ "What Do Your Recyclables Become?", www.maine.gov, Retrieved 24-11-2019. Edited"""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
      String title, String image, BuildContext context, String video) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoScreen(
                    title: title,
                    video: video,
                  )));
          // Handle video tap
        },
      ),
    );
  }

  Widget _buildArticleCard(
      String title, String image, BuildContext context, String article) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleScreen(
                    title: title,
                    article: article,
                  )));
          // Handle video tap
        },
      ),
    );
  }
}
