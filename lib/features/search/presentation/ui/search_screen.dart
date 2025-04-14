import 'dart:async';
import 'dart:developer';

import 'package:ani4h_app/common/widget/loading_state_widget.dart';
import 'package:ani4h_app/features/search/presentation/controller/search_controller.dart';
import 'package:ani4h_app/features/search/presentation/ui/widget/search_result_card.dart';
import 'package:ani4h_app/features/search/presentation/ui/widget/top_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget{
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  String searchQuery = '';
  bool _isSearched = false;
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   ref.read(searchControllerProvider.notifier).getTopSearch();
    // });
    log("initState");
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    log("dispose");
    _debounce?.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      log("Load more");
      _fetchMore();
    }
  }

  Future<void> _fetchMore() async {
    setState(() {
      _isLoading = true;
    });

    await ref.read(searchControllerProvider.notifier).fetchMoreSearch(searchQuery);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.only(right: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF121212),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });

                                  // reset PageCur
                                  ref.read(searchControllerProvider.notifier).resetPageCur();

                                  if(value.isEmpty) {
                                    _debounce?.cancel();
                                    _isSearched = false;
                                    return;
                                  }

                                  _debounce?.cancel();
                                  _debounce = Timer(const Duration(milliseconds: 300), () {
                                    ref.read(searchControllerProvider.notifier).search(searchQuery);
                                    _isSearched = true;
                                  });
                                },
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tìm kiếm',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Button Text (Cancel)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search result or Top search
            Expanded(
              child: searchQuery.isEmpty
                ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left:12),
                      child: Text(
                        'Tìm kiếm hàng đầu',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Consumer(
                        builder: (context, ref, child) {
                          final searchController = ref.watch(searchControllerProvider);

                          return
                            LoadingStateWidget(
                              isLoading: searchController.isLoading,
                              hasError: searchController.hasError,
                              errorMessage: searchController.errorMessage,
                              dataIsEmpty: searchController.topSearches.isEmpty,
                              child: Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: ref.watch(searchControllerProvider).topSearches.length,
                                    itemBuilder: (context, index) {
                                      final item = ref.watch(searchControllerProvider).topSearches[index];
                                      return TopSearchCard(item: item);
                                    },
                                  ),
                                ),
                              ),
                            );
                        }
                    )


                  ],
                )

                :
                Consumer(
                  builder: (context, ref, child) {
                    final searchController = ref.watch(searchControllerProvider);

                    return
                    LoadingStateWidget(
                      isLoading: searchController.isLoading,
                      hasError: searchController.hasError,
                      errorMessage: searchController.errorMessage,
                      dataIsEmpty: searchController.searchResults.isEmpty && _isSearched,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: searchController.searchResults.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if(index == searchController.searchResults.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final item = searchController.searchResults[index];
                            return SearchResultCard(item: item);
                          },
                        ),
                      ),
                    );
                  }
                )
            ),
          ]
        ),
      ),
    );
  }
}
