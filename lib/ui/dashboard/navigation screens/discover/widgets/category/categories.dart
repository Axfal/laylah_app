import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/category/provider/tag_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final provider = Provider.of<TagProvider>(context, listen: false);
    if (provider.tagModel == null) {
      await provider.getTags();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TagProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Consumer<CategoriesProvider>(
          builder: (context, categoryProvider, _) {
            if (provider.tagModel == null || provider.tagModel!.data!.isEmpty) {
              // SHIMMER THAT REPLICATES TAG TEXT LOOK
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 24,
                            width: 60 + (index % 3) * 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              // ACTUAL TAG UI
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: provider.tagModel!.data!.length,
                itemBuilder: (context, index) {
                  final isSelected = categoryProvider.selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      categoryProvider.updateIndex(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.tagModel!.data![index].tagName!,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? MyAppColors.dullRedColor
                                  : MyAppColors.darkGreyColor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 2,
                            width: isSelected ? 18 : 0,
                            decoration: BoxDecoration(
                              color: MyAppColors.dullRedColor,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
