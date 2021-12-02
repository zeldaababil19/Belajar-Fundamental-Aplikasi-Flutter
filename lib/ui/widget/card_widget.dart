part of 'widget.dart';

class CardRestauranWidget extends StatelessWidget {
  const CardRestauranWidget({required this.restaurant});
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                leading: Hero(
                  tag: restaurant.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      "${ApiService.imageUrl}medium/${restaurant.pictureId}",
                      width: 100,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.location_pin,
                        size: 15,
                        color: Colors.green,
                      ),
                      Text(
                        " " + restaurant.city,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ]),
                    Row(children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow,
                      ),
                      Text(
                        " " + restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ]),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
                },
              ),
            );
          },
        );
      },
    );
  }
}
