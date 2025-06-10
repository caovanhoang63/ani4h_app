import 'package:ani4h_app/common/widget/loading_state_widget.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:ani4h_app/features/history/presentation/controller/history_controller.dart';
import 'package:ani4h_app/features/history/presentation/ui/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(historyControllerProvider.notifier).fetchHistory();
    });
    _scrollController.addListener(_scrollListener);
  }
  
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !ref.read(historyControllerProvider).isLoading) {
      ref.read(historyControllerProvider.notifier).fetchMoreHistory();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử'),
        centerTitle: true,
        toolbarHeight: 76,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Consumer(builder: (context, ref, child) {
            final state = ref.watch(historyControllerProvider);

            return
              LoadingStateWidget(
                isLoading: state.isLoading,
                hasError: state.hasError,
                errorMessage: state.errorMessage,
                dataIsEmpty: state.histories.isEmpty && !state.isLoading,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.histories.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if(index == state.histories.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final item = state.histories[index];
                      return HistoryCard(item: item);
                    }
                ),
              );
          })
      ),
    );
  }
}