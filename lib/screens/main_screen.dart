import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto/components/job_carousel.dart';
import 'package:proyecto/components/job_list.dart';
import 'package:proyecto/models/company.dart';
import 'package:proyecto/models/job.dart';

class MainScreen extends StatefulWidget {
  


  MainScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Componentes en Flutter'),
          elevation: 2,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.sunny),
                  title: const Text('Nombre de ruta'),
                  onTap: () {
                    

                    Navigator.pushNamed(context, 'pedido');
                  },
                ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 10));
  }
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Job> forYouJobs = [
    Job(
      role: 'PRODUCTOS',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Emerson',
        urlLogo:
            'https://img2.freepng.es/20200413/cx/transparent-icon-design-5e9514e3e94e76.6287660515868285159556.jpg',
      ),
    ),
    Job(
      role: 'CLIENTES',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Samantha',
        urlLogo:
            'https://i.pinimg.com/736x/4b/cd/33/4bcd33ca4155ff5519bf8019a955ba73.jpg',
      ),
    ),
    Job(
      role: 'PEDIDOS',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Luis',
        urlLogo:
            'https://img2.freepng.es/20200413/cx/transparent-icon-design-5e9514e3e94e76.6287660515868285159556.jpg',
      ),
    ),
  ];

  List<Job> recentJobs = [
    Job(
      role: 'Ropa Para Dama',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Todas las Tallas',
        urlLogo:
            'https://cdn-icons-png.flaticon.com/512/3716/3716324.png',
      ),
      isFavorite: true,
    ),
    Job(
      role: 'Ropa Para Caballero',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Todas las Tallas',
        urlLogo:
            'https://cdn-icons-png.flaticon.com/512/1415/1415540.png',
      ),
      isFavorite: true,
    ),
    Job(
      role: 'Ropa Para niños',
      location: 'Quito - Ecuador',
      company: Company(
        name: 'Todas las Tallas',
        urlLogo:
            'https://w7.pngwing.com/pngs/627/727/png-transparent-romper-suit-computer-icons-t-shirt-baby-toddler-one-pieces-clothing-t-shirt.png',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _customAppBar(),
            _textsHeader(context),
            _forYou(context),
            _recent(context),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 40.0,
            icon: SvgPicture.asset('assets/icons/slider.svg'),
            onPressed: () {},
          ),
          Row(
            children: [
              IconButton(
                iconSize: 40.0,
                icon: SvgPicture.asset('assets/icons/search.svg'),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 40.0,
                icon: SvgPicture.asset('assets/icons/settings.svg'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textsHeader(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hola Usuario',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Encuentra tu próximo',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            'outfit',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  Widget _forYou(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            'Para ti',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        JobCarousel(this.forYouJobs),
      ],
    );
  }

  Widget _recent(context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Categorias',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Ver todo',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: JobList(this.recentJobs),
        ),
      ],
    );
  }
}
