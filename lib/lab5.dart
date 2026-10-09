import 'package:flutter/material.dart';

void main() {
  runApp(const ProductPreviewApp());
}

class ProductPreviewApp extends StatelessWidget {
  const ProductPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Preview',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xfff7f7fb),
      ),
      home: const ProductPreviewScreen(),
    );
  }
}

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({super.key});

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  bool _isBookmarked = false;

  void _addToCart() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Product added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Preview'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;
            final content = _ProductContent(
              isWide: isWide,
              isBookmarked: _isBookmarked,
              onBookmarkPressed: () {
                setState(() => _isBookmarked = !_isBookmarked);
              },
            );

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                isWide ? 32 : 16,
                8,
                isWide ? 32 : 16,
                24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1050),
                  child: content,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Add to Cart'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  const _ProductContent({
    required this.isWide,
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  final bool isWide;
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    final image = _ProductImage(
      isBookmarked: isBookmarked,
      onBookmarkPressed: onBookmarkPressed,
    );
    final details = _ProductDetails(isWide: isWide);

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: image),
          const SizedBox(width: 32),
          Expanded(flex: 4, child: details),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [image, const SizedBox(height: 24), details],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
              '?auto=format&fit=crop&w=1200&q=85',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: Color(0xffe3d9f8),
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 96,
                      color: Colors.deepPurple,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Material(
                color: Colors.white.withValues(alpha: 0.92),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: 'Bookmark product',
                  onPressed: onBookmarkPressed,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 16,
              bottom: 16,
              child: Chip(
                avatar: Icon(Icons.local_fire_department, size: 18),
                label: Text('Bestseller'),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(
              label: Text('New arrival'),
              labelStyle: TextStyle(color: Colors.deepPurple),
              backgroundColor: Color(0xffe9ddff),
            ),
            Chip(label: Text('Free delivery')),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Air Max Motion 3',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ...List.generate(
              5,
              (index) => const Icon(Icons.star, size: 21, color: Colors.amber),
            ),
            const SizedBox(width: 8),
            Text(
              '4.8 (126 reviews)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          '\$129.99',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        const SizedBox(height: 20),
        Text(
          'Comfortable everyday sneakers with a lightweight sole and breathable '
          'upper. Designed for active days and effortless street style.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 24),
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(label: Text('Footwear')),
            Chip(label: Text('Sport')),
            Chip(label: Text('Lifestyle')),
            Chip(label: Text('Unisex')),
          ],
        ),
        if (isWide) const SizedBox(height: 32),
      ],
    );
  }
}
