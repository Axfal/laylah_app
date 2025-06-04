// ignore_for_file: prefer_const_constructors
import 'package:laylah_app/utils/constants/exports.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  BannerWidgetState createState() => BannerWidgetState();
}

class BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // getData();
    _startAutoSlide();
  }

  void getData() async {
    final slidesProvider = Provider.of<SlidesProvider>(context, listen: false);
    await slidesProvider.getSlides();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slidesProvider = Provider.of<SlidesProvider>(context);

    final slidesData = slidesProvider.slidesModel?.data ?? [];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: slidesData.isEmpty
                ? _buildShimmer()
                : PageView.builder(
                    controller: _pageController,
                    itemCount: slidesData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final imageUrl =
                          'https://laylahnovel.com/Layla-dashboard/${slidesData[index].slideImage}';
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image)),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return _buildShimmer();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slidesData.length, (index) {
              final isActive = _currentIndex == index;
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: isActive ? 20 : 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? MyAppColors.dullRedColor
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      final slides = Provider.of<SlidesProvider>(context, listen: false)
              .slidesModel
              ?.data ??
          [];
      if (slides.isEmpty) return;
      int nextPage = (_currentIndex + 1) % slides.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
