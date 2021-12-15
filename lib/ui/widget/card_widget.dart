part of 'widget.dart';

class CardRestauranWidget extends StatelessWidget {
  const CardRestauranWidget({
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
              },
              child: Card(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                "https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId,
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Expanded(
                          Text(
                            restaurant.name,
                            style: boldBaseFont,
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: mediumBaseFont,
                                  ),
                                ],
                              ),
                              // Container(
                            ],
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Row(children: [
                            const Icon(
                              Icons.location_pin,
                              size: 15,
                              color: Colors.green,
                            ),
                            Text(
                              restaurant.city,
                              style: mediumBaseFont,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            );
          },
        );
      },
    );
  }
}
