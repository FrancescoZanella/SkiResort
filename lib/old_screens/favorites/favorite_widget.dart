import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './favorite_elements.dart';
import 'dart:io';
import 'dart:math';

// Create a global key for the widget; in this way i can get the image of the widget

class FavoriteWidget {
  static Widget favoriteWidget(Favorite favorite, context) {
    // Create an instance of WidgetsToImageController
    WidgetsToImageController controller = WidgetsToImageController();
    // Create a random integer for the hero tag
    int heroTag = Random().nextInt(1 << 32);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: WidgetsToImage(
        controller: controller,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.background
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              favorite.imageLink,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: FloatingActionButton(
                          heroTag:
                              heroTag, // set heroTag as random integer for FloatingActionButton
                          onPressed: () async {
                            // Capture image and get bytes
                            Uint8List? bytes = await controller.capture();

                            if (bytes != null) {
                              final directory =
                                  (await getApplicationDocumentsDirectory())
                                      .path;
                              File imgFile = File('$directory/screenshot.png');
                              await imgFile.writeAsBytes(bytes);

                              // ignore: deprecated_member_use
                              await Share.shareFiles(
                                [imgFile.path],
                                text:
                                    'Check out this ski resort: ${favorite.skiResortUrl}',
                              );
                            }
                          },
                          backgroundColor: Colors.black.withOpacity(0.7),
                          foregroundColor: Colors.white,
                          mini: true,
                          child: const Icon(Icons.share, size: 18.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      favorite.skiResortName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RatingBarIndicator(
                      rating: favorite.skiResortRating,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      favorite.skiResortDescription,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.height),
                    title: Text('Elevation: ${favorite.skiResortElevation}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.downhill_skiing),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text('Ski slopes: ${favorite.totalSkiSlopes}'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.blue,
                          child: Text(
                            favorite.blueSkiSlopes,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.red,
                          child: Text(
                            favorite.redSkiSlopes,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black,
                          child: Text(
                            favorite.blackSkiSlopes,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.arrow_upward),
                    title: Text('Ski lifts: ${favorite.skiLiftsNumber}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.euro_symbol_sharp),
                    title: Text('Ski Pass Cost: ${favorite.skiPassCost}'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your logic here
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: const Text('Remove from Favorites'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
