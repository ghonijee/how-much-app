import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/domain/account.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/account/get_list_account_provider.dart';

@RoutePage()
class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listAccount = ref.watch(getListAccountProvider);
    if (listAccount.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(8.h),
              const TextUI.titleRegular("Accounts"),
              FreeSpaceUI.vertical(20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextUI.smallNormalMedium("My Balance"),
                    TextUI.smallNoneBold(
                        listAccount.value!.countValue()!.currency())
                  ],
                ),
              ),
              FreeSpaceUI.vertical(20),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: listAccount.value!.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 6 / 5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    var item = listAccount.value![index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: context.theme.appColors.sky.light,
                            ),
                            child: Image.asset(
                              item.assets!,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          FreeSpaceUI.vertical(20),
                          TextUI.smallNoneBold(item.balance!.currency()),
                          FreeSpaceUI.vertical(8),
                          TextUI.smallNoneMedium(
                            item.name,
                            color: context.colors.sky.base,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
