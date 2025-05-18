import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AdminEditUsersPage extends StatefulWidget {
  const AdminEditUsersPage({super.key});

  @override
  State<AdminEditUsersPage> createState() => _AdminEditUsersPageState();
}

class _AdminEditUsersPageState extends State<AdminEditUsersPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppCubit.get(context).getAllUsers();
    });
  }

  Widget _buildShimmer() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          isThreeLine: false,
          title: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              width: double.infinity,
              height: 14,
              color: Colors.white,
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 12,
              margin: const EdgeInsets.only(top: 8),
              color: Colors.white,
            ),
          ),
          trailing: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 80,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => popNavigator(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).editUsersButton,
          style: TextStyles.appBarTitle(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is MakeAdminSuccessState ||
                state is DeleteAdminSuccessState) {
              AppCubit.get(context).getAllUsers();
              Fluttertoast.showToast(
                msg: S.of(context).success,
                backgroundColor: Colors.green,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 1,
                fontSize: 16,
              );
            }
            if (state is MakeAdminErrorState ||
                state is DeleteAdminErrorState) {
              Fluttertoast.showToast(
                msg: S.of(context).error,
                backgroundColor: Colors.red,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 1,
                fontSize: 16,
              );
            }
          },
          builder: (context, state) {
            final cubit = AppCubit.get(context);
            final users = cubit.allUsersModel?.data ?? [];

            if (state is GetAllUsersLoadingState) {
              return _buildShimmer();
            } else if (users.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).noUsersFound,
                  style: TextStyles.headline1(context),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).allUsers,
                      style: TextStyles.headline1(context)),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final fullName =
                          '${user.firstName ?? ''} ${user.lastName ?? ''}';
                      final roles = user.roles ?? [];
                      final isAdmin =
                          roles.contains('admin') || roles.contains('Admin');

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          isThreeLine: false,
                          title: Text(
                            fullName,
                            style: TextStyles.smallText(context),
                          ),
                          subtitle: Text(
                            user.email ?? '',
                            style: TextStyles.smallText(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isAdmin ? Colors.red : primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                if (isAdmin) {
                                  cubit.deleteAdmin(email: user.email!);
                                } else {
                                  cubit.makeAdmin(email: user.email!);
                                }
                              },
                              child: Text(
                                isAdmin
                                    ? S.of(context).demoteToUser
                                    : S.of(context).promoteToAdmin,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
