import 'package:codde_pi/components/dynamic_bar/cubit/dynamic_bar_cubit.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicBar extends StatelessWidget {
  final bool nested;

  DynamicBar({this.nested = false});

  final PageController _pageController = PageController();

  int get currentPage =>
      _pageController.positions.isNotEmpty ? _pageController.page!.toInt() : 0;

  @override
  Widget build(BuildContext context) {
    final _pages = context.select((DynamicBarCubit cubit) => cubit.state.pages);
    final _paged = context.select((DynamicBarCubit cubit) => cubit.state.paged);
    final fab = context.select((DynamicBarCubit cubit) => cubit.state.fab);

    return Scaffold(
      body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages),
      bottomNavigationBar: BottomAppBar(
        child: Row(children: [
          if (nested) ...[
            IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.exit_to_app)),
            const Divider(
              thickness: 2.0,
            )
          ],
          ..._paged.map((DynamicBarDestination e) => IconButton(
              onPressed: () =>
                  context.read<DynamicBarCubit>().setPage(_pageController, e),
              icon: Icon(e.iconData))),
          if (fab != null)
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () => fab.action != null ? fab.action!() : {},
                  child: Icon(fab.iconData),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
